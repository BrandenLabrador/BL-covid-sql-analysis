-- 05_country_rankings.sql
-- Country rankings and comparisons

-- Highest total cases (latest)
SELECT
  location,
  MAX(total_cases) AS total_cases
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_cases DESC
LIMIT 25;

-- Highest total deaths (latest)
SELECT
  location,
  MAX(total_deaths) AS total_deaths
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_deaths DESC
LIMIT 25;

-- Highest deaths per million (latest)
SELECT
  location,
  MAX(total_deaths_per_million) AS deaths_per_million
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY deaths_per_million DESC
LIMIT 25;

-- Highest infection rate (cases as % of population)
SELECT
  location,
  MAX(population) AS population,
  MAX(total_cases) AS total_cases,
  ROUND(MAX(total_cases) / NULLIF(MAX(population), 0) * 100, 2) AS pct_infected
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY pct_infected DESC
LIMIT 25;


