SELECT
	* 
FROM
	`covid death 1` --
-- Comments goes here
--

ORDER BY
	3, 4 
	
-- SELECT the data we gonna use
SELECT
	location,
	DATE,
	total_cases,
	new_cases,
	total_deaths,
	population 
FROM
	`covid death 1` 
ORDER BY
	1, 2 
	
-- looking at totalcases vs total death
SELECT
	location,
	DATE,
	total_cases,
	total_deaths,
	( total_deaths / total_cases ) * 100 AS deathpercent 
FROM
	`covid death 1` 
WHERE
	location LIKE "%state%" 
ORDER BY
	1,2 
	
-- looking for total cases vs population
SELECT
	location,
	DATE,
	total_cases,
	total_deaths,
	population,
	( total_cases / population ) * 100 AS deathpercent 
FROM
	`covid death 1` 
WHERE
	location LIKE "%state%" 
ORDER BY
	1, 2 
	
	
-- looking country that have highest infection rate compare to population
SELECT
	location,
	population,
	MAX( total_cases ) AS highinfecrate,
	MAX( ( total_cases / population ) ) * 100 percentpopulationinfect 
FROM
	`covid death 1` 
GROUP BY
	location,
	population 
ORDER BY
	percentpopulationinfect DESC 
	
-- showing contriest with highest dead count per population
SELECT
	location,
	MAX( total_deaths ) AS total_deathscount 
FROM
	`covid death 1` 
WHERE
	continent IS NOT NULL 
GROUP BY
	location 
ORDER BY
	total_deathscount DESC

-- lets break down into continenct
SELECT
	location,
	MAX( total_deaths ) AS total_deathscount 
FROM
	`covid death 1` 
WHERE
	continent IS NOT NULL 
GROUP BY
	location 
ORDER BY
	total_deathscount DESC 
	
	
-- showing continent with the highest death count per population
SELECT
	location,
	MAX( total_deaths ) AS total_deathscount 
FROM
	`covid death 1` 
WHERE
	continent IS NOT NULL 
GROUP BY
	location 
ORDER BY
	total_deathscount DESC 
	
	
-- global number
SELECT
	-- DATE,
	SUM( new_cases ) AS totalcase,
	SUM( new_deaths ) AS totaldeath,
	sum( new_deaths ) / SUM( new_cases ) * 100 AS deathpercent 
FROM
	`covid death 1` 
WHERE
	continent IS NOT NULL 
-- GROUP BY date 
ORDER BY 1,2
	
	
SELECT * 
from `covid vaccine 2`


-- looking for total population vs vaccination
SELECT
	dea.continent,
	dea.location,
	dea.date,
	dea.population,
	vac.new_vaccinations,
	sum(vac.new_vaccinations) over (PARTITION by dea.location ORDER BY dea.location,dea.date) as rollingpeoplevaccinate

FROM
	`covid death 1` AS dea
	JOIN `covid vaccine 2` AS vac 
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent is not null

order by 2,3
 
 
 -- use cte
 WITH PopvsVac (continent,location,date,population,new_vaccinations,rollingpeoplevaccinate)
 AS
 (
 
 SELECT
	dea.continent,
	dea.location,
	dea.date,
	dea.population,
	vac.new_vaccinations,
	sum(vac.new_vaccinations) over (PARTITION by dea.location ORDER BY dea.location,dea.date) as rollingpeoplevaccinate

FROM
	`covid death 1` AS dea
	JOIN `covid vaccine 2` AS vac 
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent is not null

-- order by 2,3
	)
	
SELECT *
from PopvsVac
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	