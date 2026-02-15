-- 03_kpis.sql
-- KPI definitions and calculations

-- 1) Case Fatality Rate (CFR) by country (latest snapshot)
-- CFR = total_deaths / total_cases
SELECT
  location,
  MAX(total_cases) AS total_cases,
  MAX(total_deaths) AS total_deaths,
  ROUND(MAX(total_deaths) / NULLIF(MAX(total_cases), 0) * 100, 2) AS case_fatality_rate_pct
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
HAVING MAX(total_cases) >= 100000  -- threshold to reduce noise
ORDER BY case_fatality_rate_pct DESC
LIMIT 25;

-- 2) Infection rate vs population (latest)
SELECT
  location,
  MAX(population) AS population,
  MAX(total_cases) AS total_cases,
  ROUND(MAX(total_cases) / NULLIF(MAX(population), 0) * 100, 2) AS pct_population_infected
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY pct_population_infected DESC
LIMIT 25;

-- 3) Global CFR over time (daily)
SELECT
  date,
  SUM(new_cases) AS global_new_cases,
  SUM(new_deaths) AS global_new_deaths,
  ROUND(SUM(new_deaths) / NULLIF(SUM(new_cases), 0) * 100, 2) AS global_daily_cfr_pct
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

-- 4) 7-day moving average (global new cases/deaths)
-- Window functions required (MySQL 8+)
WITH daily AS (
  SELECT
    date,
    SUM(new_cases) AS global_new_cases,
    SUM(new_deaths) AS global_new_deaths
  FROM coviddeaths
  WHERE continent IS NOT NULL
  GROUP BY date
)
SELECT
  date,
  global_new_cases,
  global_new_deaths,
  ROUND(AVG(global_new_cases) OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS ma7_new_cases,
  ROUND(AVG(global_new_deaths) OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS ma7_new_deaths
FROM daily
ORDER BY date;

