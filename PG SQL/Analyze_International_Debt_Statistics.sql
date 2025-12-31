SELECT * FROM public.international_debt
LIMIT 5;

/*What is the number of distinct countries present in the database? 
The output should be single row and column aliased as total_distinct_countries. 
Save the query as num_distinct_countries.*/
-- query saved as num_district_countries
-- num_distinct_countries

SELECT COUNT(DISTINCT country_name) AS total_distinct_countries
FROM public.international_debt;

--total_disinct_countries = 124


/*What country has the highest amount of debt? 
Your output should contain two columns: country_name and total_debt and one row. 
Save the query as highest_debt_country.*/
--query saved as highest_debt_country
--highest_debt_country

SELECT country_name, SUM(debt) AS total_debt
FROM public.international_debt
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 1;

--country_name = China
--total_debt = 285793494734.2


/*What country has the highest amount of debt? 
Your output should contain two columns: country_name and total_debt and one row. 
Save the query as highest_debt_country.*/
-- query saved as highest_debt_country
-- lowest_principal_repayment


SELECT country_name, indicator_name, SUM(debt) AS lowest_repayment
FROM public.international_debt
WHERE indicator_code = 'DT.AMT.DLXF.CD'
GROUP BY country_name, indicator_name
ORDER BY lowest_repayment ASC
LIMIT 1;


--country_name = Timor-Leste
--indicator_number = Princial repayments on external debt,...
--lowest_number = 825000
