--query the product_emissions table
SELECT * FROM public.product_emissions
LIMIT 5;

-- Find the most recent year
SELECT DISTINCT year
FROM public.product_emissions
ORDER BY year DESC;

--carbon_emissions_by_industry
SELECT industry_group, 
       COUNT(DISTINCT company) AS num_companies,
       ROUND(SUM(carbon_footprint_pcf), 1) AS total_industry_footprint
FROM public.product_emissions
WHERE year = 2017
GROUP BY industry_group
ORDER BY total_industry_footprint DESC;
