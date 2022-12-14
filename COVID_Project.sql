Select * 
from PortfolioProject.dbo.CovidDeaths
where continent is not NULL
order by 3,4

--select *
--from PortfolioProject.dbo.CovidVaccinations
--order by 3,4

-- select data that we are going to be using

select Location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject.dbo.CovidDeaths
where continent is not NULL
order by 1,2

-- looking at total cases vs total deaths
-- shows likelihood of dying of COVID contraction in your country (United Statesa as example)

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
from PortfolioProject.dbo.CovidDeaths
where location = 'United States'
order by 1,2

-- looking at total cases vs population
-- shows what percentage of population got COVID

select Location, date, total_cases, population, (total_cases/population)*100 as Percent_COVID_Population
from PortfolioProject.dbo.CovidDeaths
--where location = 'United States'
order by 1,2

--looking at countries with highest infection rate compared to population

select Location, MAX(total_cases) as Highest_Infection_Count, population, (MAX(total_cases)/population)*100 as Percent_COVID_Population
from PortfolioProject.dbo.CovidDeaths
--where location = 'United States'
group by Location, population
order by Percent_COVID_Population desc


-- showing countries with highest death count per population

select Location, MAX(total_deaths) as Total_Death_Count
from PortfolioProject.dbo.CovidDeaths
where continent is not NULL
group by Location
order by Total_Death_Count desc

-- let's break things down by continent 

select continent, MAX(total_deaths) as Total_Death_Count
from PortfolioProject.dbo.CovidDeaths
where continent is not NULL
group by continent
order by Total_Death_Count desc

-- below is a more accurate representation of all continents 

select location, MAX(total_deaths) as Total_Death_Count
from PortfolioProject.dbo.CovidDeaths
where continent is NULL and location NOT LIKE '%income%'
group by [location]
order by Total_Death_Count desc

-- Global Death Rate numbers by date and by total 
-- date grouped first 
select date, sum(new_cases) as Total_New_Cases_Globably, sum(new_deaths) as Total_New_Deaths_Globaly, (sum(new_deaths)/sum(new_cases))*100 as Total_Death_Percentage
from PortfolioProject.dbo.CovidDeaths
where continent is not null 
group by date
order by 1,2

-- total of all time 

select sum(new_cases) as Total_New_Cases_Globably, sum(new_deaths) as Total_New_Deaths_Globaly, (sum(new_deaths)/sum(new_cases))*100 as Total_Death_Percentage
from PortfolioProject.dbo.CovidDeaths
where continent is not null 
order by 1,2

-- Moving to the Covid Vaccinations table 

select *
from PortfolioProject.dbo.CovidVaccinations

-- joining both tables

select *
from PortfolioProject.dbo.CovidDeaths dea
JOIN PortfolioProject.dbo.CovidVaccinations vac
    on dea.location= vac.location
    and dea.date=vac.date

-- looking at total population vc vaccinations 

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from PortfolioProject.dbo.CovidDeaths dea
JOIN PortfolioProject.dbo.CovidVaccinations vac
    on dea.location= vac.location
    and dea.date=vac.date
where dea.continent is not null 
order by 1,2,3

-- making a rolling count of vaccinations per country and using that to compare to population

-- using a CTE

With Pop_vs_Vac (Continent, location, date, population, new_vaccinations, Rolling_Vaccination_Count)
AS
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (partition by dea.location order by dea.location, dea.date) as Rolling_Vaccination_Count
-- (Rolling_Vaccination_Count/population)*100 as Percent_Vaccinated
from PortfolioProject.dbo.CovidDeaths dea
JOIN PortfolioProject.dbo.CovidVaccinations vac
    on dea.location= vac.location
    and dea.date=vac.date
where dea.continent is not null 
--order by 2,3
)

select *, (Rolling_Vaccination_Count/population)*100 as Percent_Vaccinated
from Pop_vs_Vac

-- using a temp table

DROP TABLE if exists #Percent_Population_Vaccinated -- included to prevent errors
create table #Percent_Population_Vaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population NUMERIC,
new_vaccinations NUMERIC, 
Rolling_Vaccination_Count numeric    
)

Insert into #Percent_Population_Vaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (partition by dea.location order by dea.location, dea.date) as Rolling_Vaccination_Count
-- (Rolling_Vaccination_Count/population)*100 as Percent_Vaccinated
from PortfolioProject.dbo.CovidDeaths dea
JOIN PortfolioProject.dbo.CovidVaccinations vac
    on dea.location= vac.location
    and dea.date=vac.date
--where dea.continent is not null 
--order by 2,3

select *, (Rolling_Vaccination_Count/population)*100 as Percent_Vaccinated
from #Percent_Population_Vaccinated

-- creating view to store data for later visualizations

create View Percent_Population_Vac as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (partition by dea.location order by dea.location, dea.date) as Rolling_Vaccination_Count
-- (Rolling_Vaccination_Count/population)*100 as Percent_Vaccinated
from PortfolioProject.dbo.CovidDeaths dea
JOIN PortfolioProject.dbo.CovidVaccinations vac
    on dea.location= vac.location
    and dea.date=vac.date
where dea.continent is not null 
--order by 2,3

select * 
from Percent_Population_Vac