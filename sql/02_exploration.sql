-- 02_exploration.sql
-- General exploration queries

-- Latest snapshot per country (cases and deaths)
SELECT
  location,
  MAX(date) AS latest_date,
  MAX(total_cases) AS total_cases,
  MAX(total_deaths) AS total_deaths
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_cases DESC
LIMIT 25;

-- Global totals over time (daily new)
SELECT
  date,
  SUM(new_cases) AS global_new_cases,
  SUM(new_deaths) AS global_new_deaths
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

-- Top 10 peak days (global new cases)
SELECT
  date,
  SUM(new_cases) AS global_new_cases
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY global_new_cases DESC
LIMIT 10;

-- Countries with the highest deaths per million (latest)
SELECT
  location,
  MAX(total_deaths_per_million) AS deaths_per_million
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY deaths_per_million DESC
LIMIT 25;

