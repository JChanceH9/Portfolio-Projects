--Death Rate of Infected Individuals from 2020-2023
--select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as InfectedDeathRate
--from CovidDeaths2023
--where location like '%States%'
--order by 1, 2

--Percentage of United States Population Infected
--select location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
--from CovidDeaths2023
--where location like '%States%'
--order by 1, 2

--Countries with Highest Infection Rate 
--select location, population, max(total_cases) as MaxInfectedNumber, max((total_cases/population))*100 as InfectionRate
--from CovidDeaths2023
--group by location, population
--order by InfectionRate desc

--Total Population Mortality Rate by Continent
--select continent, max(population) as Population, max(total_deaths) as TotalDeaths, (max(total_deaths)/max(population))*100 as MortalityRate
--from CovidDeaths2023
--where continent is not null
--group by continent
--order by MortalityRate desc

--Total Population Mortality Rate by Country
--select location, max(population) as Population, max(total_deaths) as TotalDeaths, (max(total_deaths)/max(population))*100 as MortalityRate
--from CovidDeaths2023
--where continent is not null
--group by location

--2023 Global Infected Mortality Rate
--select sum(new_cases) as TotalCases, sum(new_deaths) as TotalDeaths, sum(new_deaths)/sum(new_cases)*100 as InfectedMortalityYTD
--from CovidDeaths2023
--where continent is not null
--order by 1, 2

--Total Global Infected Mortality Rate
--select max(total_cases) as TotalCases, max(total_deaths) as TotalDeaths, max(total_deaths)/max(total_cases)*100 as TotalInfectedMortality
--from CovidDeaths2023
--where continent is not null
--order by 1, 2

--2023 US Infected Mortality Rate
--select sum(new_cases) as TotalCases, sum(new_deaths) as TotalDeaths, sum(new_deaths)/sum(new_cases)*100 as InfectedMortalityYTD
--from CovidDeaths2023
--where location like '%states%'
--order by 1, 2

--Total US Infected Mortality Rate
--select max(total_cases) as TotalCases, max(total_deaths) as TotalDeaths, max(total_deaths)/max(total_cases)*100 as TotalInfectedMortality
--from CovidDeaths2023
--where location like '%states%'
--order by 1, 2

--Rolling Vaccination by Country
--select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--, sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--from CovidDeaths2023 dea
--join CovidVaccinations2023 vac
--on dea.location = vac.location 
--and dea.date = vac.date
--where dea.continent is not null
--and vac.new_vaccinations is not null
--order by 1, 2, 3

--Rolling Percentage of Population Vaccinated by Country
--with PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
--as
--(
--select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--, sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--from CovidDeaths2023 dea
--join CovidVaccinations2023 vac
--on dea.location = vac.location 
--and dea.date = vac.date
--where dea.continent is not null
--and vac.new_vaccinations is not null
--)
--select *, (RollingPeopleVaccinated/population)*100 as PercentagePopulationVaccinated
--from PopvsVac

