**Project Overview**

This project analyzes global COVID-19 case, death, testing, and vaccination data using MySQL. The objective is to transform raw public health data into structured analytical insights through data cleaning, normalization, aggregation, and time-series analysis. By combining case and vaccination datasets, this project evaluates global trends, country-level impact, vaccination progress, and testing metrics throughout the pandemic period.

This repository is organized as a reproducible SQL workflow: initial data quality checks, exploratory queries, KPI calculations, time-series trends, country rankings, vaccination progress analysis, and reusable views. The focus is on core data analyst skills including data preparation, aggregation, ranking, joins, and time-based analysis.

**Objectives:**  
The analysis seeks to answer the following questions:  
1.  How did global cases and deaths evolve over time?  
2.  Which countries experienced the highest total and population-adjusted impact?  
3.  Which countries reported the highest case fatality rates after applying a minimum threshold?  
4.  How did vaccination progress vary across countries?  
5.  Is there an observable relationship between vaccination coverage and deaths per million?  
6.  Which countries reported high positive test rates or low tests per case, potentially indicating testing gaps?

**Data**

Tables Used:
- coviddeaths
- covidvaccinations

Date Range:
- 2020-01-01 to 2021-04-30
  
Key Columns:
- date
- location
- population
- total_cases
- total_deaths
- new_cases
- new_deaths
- people_fully_vaccinated_per_hundred
- positive_rate
- tests_per_case

**Key Findings:**
- Global daily new cases and deaths increased steadily throughout 2020, with clear surge periods corresponding to major pandemic waves prior to April 2021.
- Population-adjusted mortality (deaths per million) revealed different country rankings compared to raw totals, highlighting disproportionate impact in certain regions.
- Case fatality rates varied significantly across countries when applying a minimum case threshold, demonstrating the importance of filtering low-volume outliers.
- Early vaccination rollout progress differed substantially by country, with some nations achieving significantly higher fully vaccinated percentages by April 2021.
- High reported positive rates combined with low tests per case in several countries suggest potential under-testing or limited testing capacity during peak periods.


**How to Run:**  
1.  Download COVID-19 datasets from Our World in Data.
2.  Import CSV files into MySQL.
3.  Normalize date and numeric columns.
4.  Execute SQL scripts in the /sql folder in order:
    - 01_data_quality_checks.sql
    - 02_exploration.sql
    - 03_kpis.sql
    - 04_trends_time_series.sql
    - 05_country_rankings.sql
    - 06_vaccination_progress.sql
    - 07_testing_insights.sql
    - 08_views.sql
