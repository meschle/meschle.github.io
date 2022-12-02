## California Wildfires 2013-2019: Patterns among the data

**Project description:**
As the effects of climate change become ever present in our world, environmental destruction is starting to become more of a commonality rather than a rarity. One such effect of climate change is the increase in wildfires, as seen within the state of California. The purpose of this project was to use statistical analysis and data visualization tools to find trends among this dataset that could be helpful for prevention of wildfires as well as any points for future analysis. In addition, this page will document the progress through analysis and visualization for this project, including SQL queries, statistical analysis using R, and visualization using Tableau. 


The dataset used was taken from a public access data set on Kaggle titled [California Wildfires 2013-2020](https://www.kaggle.com/datasets/ananthu017/california-wildfire-incidents-20132020), the data in this dataset was originally sourced from [CalFire](https://www.fire.ca.gov/), the website of the California Department of Forestry and Fire Protection. The data included information on the location (longitude, latitude, and county name) of the fire, the amount of acres burned, the name of the fire, the resources used to contain the fire, the fatalities and injuries from the fire, and the start and entinguish time of the fire among various other variables recorded. 
___

### 1. Data Validation and Cleaning

After sourcing the data (as mentioned above), the data was uploaded to Google Sheets for validation and cleaning purposes and titled [Wildfire Data Set](https://docs.google.com/spreadsheets/d/1weJfy82Y5t81W9aCjvGJNXxm4e0UUFGdOeAIY5QBY4U/edit#gid=1248527850). In order to prevent disrupting the original data, a copy of the original data was made for safe keeping and validation. After, a cleaning log was created to document the steps taken for cleaning.

Some cleaning steps taken include removing duplicate entries using the UniqueId column, which gave a unique ID to each fire, thus none of them should have been duplicated. Additionally, removing an unnecessary columns and information that was unneeded for this analysis, for instance the ControlStatement and ConditionStatement columns. Since analysis would be taking place using time elements, attention was given to format all dates correctly and to create a duration column to calculate the amount of days taken to extinguish the fire. However, when calculating duration, some errors in the EntinguishTime column where noted, including some extinguish dates measuring all the way back in 1963 and 470 incidents all recorded with the same extinguish date of 1-9-2018, it was decided to remove the extinguish dates from these entries and leave then `null` instead. 

Please see [cleaning log](https://docs.google.com/spreadsheets/d/1weJfy82Y5t81W9aCjvGJNXxm4e0UUFGdOeAIY5QBY4U/edit#gid=1248527850) for mmore detailed steps taken for data cleaning. 

```javascript
if (isAwesome){
  return true
}
```

### 2. Assess assumptions on which statistical inference will be based

```javascript
if (isAwesome){
  return true
}
```

### 3. Support the selection of appropriate statistical tools and techniques

<img src="images/dummy_thumbnail.jpg?raw=true"/>

### 4. Provide a basis for further data collection through surveys or experiments

Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. 

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).