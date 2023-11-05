select *
from PortfolioProject..CovidDeaths$
where continent is not null
order by 3,4

--select *
--from PortfolioProject..CovidVaccinations$
--order by 3,4


select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths$
order by 1,2

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathprecantage
from CovidDeaths$
where location like '%israel%'
order by 1,2


-- Looking at Total Cases vs Population
-- Shows what precentage of population got Covid
select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
from CovidDeaths$
where location like '%israel%'
order by 1,2


-- Looking at Countries with Highest Infection Rate compared to Population

select location, population, max(total_cases) as 
HighestInfectionCount, Max((total_cases/population)*100) as PercentPopulationInfected
from CovidDeaths$
where continent is not null
-- where location like '%israel%'
Group by location, population
order by PercentPopulationInfected DESC


-- Let's break things down by continent


-- Showing Countries with Heighest Death Count per Population
select location, max(cast(total_deaths as int)) as TotalDeathCount
from CovidDeaths$
where continent is not null
-- where location like '%israel%'
Group by location
order by TotalDeathCount DESC


-- Showing continents with the heighest death count per population

select continent, max(cast(total_deaths as int)) as TotalDeathCount
from CovidDeaths$
where continent is not null
-- where location like '%israel%'
Group by continent
order by TotalDeathCount DESC


-- GLOBAL NUMBERS

select  sum(new_cases) as totalCases, sum(cast(new_deaths as int)) as TotalDeaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as
DeathPrecentage
from CovidDeaths$
-- where location like '%israel%'
where continent is not null
--group by date
order by 1,2


-- Looking at Total Population vs Vaccinations


-- USE CTE

With PopvsVac(Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast (vac.new_vaccinations as int)) over 
(partition by dea.location order by dea.location, dea.date)
as RollingPeopleVaccinated
from CovidDeaths$ dea
join CovidVaccinations$ vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
--order by 2, 3
)



select *, (RollingPeopleVaccinated/Population)*100
from PopvsVac


-- TEMP TABLE

drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast (vac.new_vaccinations as int)) over 
(partition by dea.location order by dea.location, dea.date)
as RollingPeopleVaccinated
from CovidDeaths$ dea
join CovidVaccinations$ vac
on dea.location=vac.location
and dea.date=vac.date
-- where dea.continent is not null
--order by 2, 3


select *, (RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated


-- Create View to store data for later visualizations


Create View PercentPopulationVaccinated as 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast (vac.new_vaccinations as int)) over 
(partition by dea.location order by dea.location, dea.date)
as RollingPeopleVaccinated
from CovidDeaths$ dea
join CovidVaccinations$ vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null


select *
from PercentPopulationVaccinated
