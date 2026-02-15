-- 07_testing_insights.sql
-- Testing metrics (where available)

-- Countries with the highest positive rate (latest)
SELECT
  location,
  MAX(positive_rate) AS max_positive_rate
FROM covidvaccinations
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY max_positive_rate DESC
LIMIT 25;

-- Countries with lowest tests per case (latest) - proxy for under-testing
SELECT
  location,
  MAX(tests_per_case) AS tests_per_case
FROM covidvaccinations
WHERE continent IS NOT NULL
GROUP BY location
HAVING MAX(tests_per_case) IS NOT NULL
ORDER BY tests_per_case ASC
LIMIT 25;

-- Trend: positive rate over time for selected countries
SELECT
  location,
  date,
  positive_rate,
  tests_per_case,
  new_tests_smoothed_per_thousand
FROM covidvaccinations
WHERE location IN ('United States', 'Italy', 'Brazil')
ORDER BY location, date;


