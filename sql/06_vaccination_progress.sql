-- 06_vaccination_progress.sql
-- Vaccination progress analysis and joins

-- Latest vaccination snapshot per country
SELECT
  location,
  MAX(date) AS latest_date,
  MAX(people_vaccinated) AS people_vaccinated,
  MAX(people_fully_vaccinated) AS people_fully_vaccinated,
  MAX(total_vaccinations) AS total_vaccinations,
  MAX(people_fully_vaccinated_per_hundred) AS fully_vax_per_100
FROM covidvaccinations
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY fully_vax_per_100 DESC
LIMIT 25;

-- Vaccination progress over time for selected countries
SELECT
  location,
  date,
  people_vaccinated_per_hundred,
  people_fully_vaccinated_per_hundred,
  total_vaccinations_per_hundred
FROM covidvaccinations
WHERE location IN ('United States', 'Italy', 'Brazil')
ORDER BY location, date;

-- Rolling new vaccinations (7-day average) for selected countries
WITH vax AS (
  SELECT
    location,
    date,
    new_vaccinations
  FROM covidvaccinations
  WHERE location IN ('United States', 'Italy', 'Brazil')
)
SELECT
  location,
  date,
  new_vaccinations,
  ROUND(AVG(new_vaccinations) OVER (PARTITION BY location ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS ma7_new_vaccinations
FROM vax
ORDER BY location, date;

-- Join deaths + vaccinations on (location, date) to compare trends
SELECT
  d.location,
  d.date,
  d.new_cases,
  d.new_deaths,
  v.new_vaccinations,
  v.people_fully_vaccinated_per_hundred
FROM coviddeaths d
JOIN covidvaccinations v
  ON d.location = v.location
 AND d.date = v.date
WHERE d.location IN ('United States', 'Italy', 'Brazil')
ORDER BY d.location, d.date;


