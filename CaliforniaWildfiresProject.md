## California Wildfires 2013-2019: Patterns among the data

**Project description:**
As the effects of climate change become ever present in our world, environmental destruction is starting to become more of a commonality rather than a rarity. One such effect of climate change is the increase in wildfires, as seen within the state of California. The purpose of this project was to use statistical analysis and data visualization tools to find trends among this dataset that could be helpful for prevention of wildfires as well as any points for future analysis. In addition, this page will document the progress through analysis and visualization for this project, including SQL queries, statistical analysis using R, and visualization using Tableau. 


The dataset used was taken from a public access data set on Kaggle titled [California Wildfires 2013-2020](https://www.kaggle.com/datasets/ananthu017/california-wildfire-incidents-20132020), the data in this dataset was originally sourced from [CalFire](https://www.fire.ca.gov/), the website of the California Department of Forestry and Fire Protection. The data included information on the location (longitude, latitude, and county name) of the fire, the amount of acres burned, the name of the fire, the resources used to contain the fire, the fatalities and injuries from the fire, and the start and entinguish time of the fire among various other variables recorded. 
___

### 1. Data Validation and Cleaning

After sourcing the data (as mentioned above), the data was uploaded to Google Sheets for validation and cleaning purposes and titled [Wildfire Data Set](https://docs.google.com/spreadsheets/d/1weJfy82Y5t81W9aCjvGJNXxm4e0UUFGdOeAIY5QBY4U/edit#gid=1248527850). In order to prevent disrupting the original data, a copy of the original data was made for safe keeping and validation. After, a cleaning log was created to document the steps taken for cleaning.

Some cleaning steps taken include removing duplicate entries using the UniqueId column, which gave a unique ID to each fire, thus none of them should have been duplicated. Additionally, removing an unnecessary columns and information that was unneeded for this analysis, for instance the ControlStatement and ConditionStatement columns. Since analysis would be taking place using time elements, attention was given to format all dates correctly and to create a duration column to calculate the amount of days taken to extinguish the fire. However, when calculating duration, some errors in the EntinguishTime column where noted, including some extinguish dates measuring all the way back in 1963 and 470 incidents all recorded with the same extinguish date of 1-9-2018, it was decided to remove the extinguish dates from these entries and leave then `null` instead. 

Please see [cleaning log](https://docs.google.com/spreadsheets/d/1weJfy82Y5t81W9aCjvGJNXxm4e0UUFGdOeAIY5QBY4U/edit#gid=1248527850) for more detailed steps taken for data cleaning. 

<img src="images/Screen Shot 2022-12-02 at 3.31.51 PM.png?raw=true"/>

### 2. SQL Analysis using BigQuery

Next, some basic SQL analyses were preformed to get a better understanding of the general trends among the data. The BigQuery SQL server was used to preform these analyses. Below are some examples of these SQL queries along with their results. 

1. Total Acres Burned per Year over 2013-2019
```SQL
SELECT 
  ArchiveYear as Year,
  SUM(AcresBurned) as Total_Acres_Burned
FROM `wildfires-1878-2019.California_Wildfires.wildfires`
GROUP BY ArchiveYear
ORDER BY ArchiveYear ASC
```
Results pulled: 

<img src="images/BQ.results.totalperyear.png?raw=true" width="300"/>

2. Counties with the Most Fires over 2013-2019
```SQL
SELECT
  Counties as Counties, 
  Count(AcresBurned) as Total_Fire_Incidents
FROM `wildfires-1878-2019.California_Wildfires.wildfires` 
GROUP BY Counties
ORDER BY Total_Fire_Incidents DESC LIMIT 10
```
Results pulled:

<img src="images/BQ.wildfire.top10count.png?raw=true" width="300"/>

3. Average Duration of Wildfires in Days per Year

```SQL 
SELECT 
  ArchiveYear as Year,
  ROUND(AVG(DurationDays),2) as Duration_in_Days
FROM `wildfires-1878-2019.California_Wildfires.wildfires` 
GROUP BY ArchiveYear
ORDER BY ArchiveYear ASC
```
Results pulled: 

<img src="images/BQ.wildfire.avgdurpery.png?raw=true" width="300"/>

4. Counties with Above Average Durations of Wildfires and Total Fires Above Duration and Length of Fires
``` SQL
SELECT 
  Counties as Counties,
  COUNT(AcresBurned) as Total_Fires_Above_Avg_Duration,
  ROUND(AVG(DurationDays),2) as Avg_Duration_of_Fires_Above_Duration
FROM `wildfires-1878-2019.California_Wildfires.wildfires`
WHERE DurationDays>(SELECT AVG(DurationDays) from `wildfires-1878-2019.California_Wildfires.wildfires`)
GROUP BY Counties
ORDER BY AVG(DurationDays) DESC Limit 10
```
Results pulled: 

<img src="images/BQ.wildfire.counties.duration.avg.png?raw=true" width="600"/>

5. Fires with Above Average Duration Along with Acres Burned and Year of Fire
``` SQL
SELECT
  Name as Name,
  AcresBurned as Acres_Burned,
  ROUND(DurationDays,2) as Duration_in_Days,
  ArchiveYear as Year
FROM `wildfires-1878-2019.California_Wildfires.wildfires`
WHERE DurationDays>(Select AVG(DurationDays) from `wildfires-1878-2019.California_Wildfires.wildfires`)
ORDER BY Duration_in_Days DESC LIMIT 10
```
Results pulled:


____


### 3. Support the selection of appropriate statistical tools and techniques

<img src="images/dummy_thumbnail.jpg?raw=true"/>

### 4. Provide a basis for further data collection through surveys or experiments

Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. 

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).
