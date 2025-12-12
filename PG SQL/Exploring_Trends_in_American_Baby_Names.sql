-- view the data in baby_names
SELECT * 
FROM public.baby_names
LIMIT 10;

/* name types
--List the overall top five names in alphabetical order and find out if each name is "Classic" or "Trendy" */
SELECT first_name,
       COUNT(year) as sum,
       CASE WHEN COUNT(year) < 50 THEN 'Trendy'
            ELSE 'Classic'
       END AS popularity_type
FROM public.baby_names
GROUP BY first_name
ORDER BY first_name ASC
LIMIT 5;

/* top_20
--what were the top 20 male names oversall, and how did the name Paul rank? */
SELECT first_name, SUM(num) AS sum,
       ROW_NUMBER()
       OVER (ORDER BY SUM(num) DESC) AS name_rank
FROM public.baby_names
WHERE sex = 'M'
GROUP BY first_name
LIMIT 20;

/* a_names
--which female names appeared in both 1920 and 2020? */
SELECT t1.first_name, (t1.num + t2.num) AS total_occurrences
FROM public.baby_names AS t1
INNER JOIN public.baby_names AS t2
ON t1.first_name = t2.first_name
WHERE t1.year = 1920 AND t1.sex = 'F' AND t2.year = 2020 AND t2.sex = 'F';


