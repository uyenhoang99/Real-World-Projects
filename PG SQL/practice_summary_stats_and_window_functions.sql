
--numbering rows
SELECT *,
       ROW_NUMBER() OVER() AS row_n
FROM public.summer
ORDER BY row_n ASC;


--numbering olympic games in ascending order
SELECT year, 
       ROW_NUMBER() OVER() AS row_n
FROM(
    SELECT DISTINCT year 
    FROM public.summer
    ORDER BY year ASC
) AS years
ORDER BY year ASC;

--numbering olympic games in descending order
SELECT year,
       ROW_NUMBER() OVER(ORDER BY year DESC) AS row_n
FROM(
    SELECT DISTINCT year
    FROM public.summer
) AS years
ORDER BY year;


--numbering olympic athletes by medals earned
WITH athlete_medals AS(
    SELECT athlete,
       COUNT(medal) AS medals
    FROM public.summer
    GROUP BY athlete
    ORDER BY medals DESC
)

SELECT athlete,
       ROW_NUMBER() OVER(ORDER BY medals DESC) AS row_n
FROM athlete_medals
ORDER BY medals DESC;

--reigning weightlifting champions
WITH weightlifting_gold AS(
    SELECT year, country AS champion
    FROM public.summer
    WHERE
      discipline = 'Weightlifting' AND
      event = '69KG' AND
      gender = 'Men' AND
      medal = 'Gold'
)

SELECT year, champion,
       LAG(champion) OVER
          (ORDER BY champion ASC) AS last_champion
FROM weightlifting_gold
ORDER BY year ASC;

--reigning champions by gender
WITH tennis_gold AS(
    SELECT DISTINCT gender, year, country
    FROM public.summer
    WHERE
      year >= 2000 AND
      event = 'Javelin Throw' AND
      medal = 'Gold'
)

SELECT gender, year, country AS champion,
       LAG(country) OVER(PARTITION BY gender ORDER BY year ASC) AS last_champion
FROM tennis_gold
ORDER BY gender ASC, year ASC;


--reigning champions by gender and event
WITH athletics_gold AS(
    SELECT DISTINCT gender, year, event, country
    FROM public.summer
    WHERE
      year >= 2000 AND
      discipline = 'Athletics' AND
      event IN('100M', '10000M') AND
      medal = 'Gold'
)

SELECT gender, year, event, country AS champion,
       LAG(country) 
       OVER(PARTITION BY gender, event ORDER BY year ASC) AS last_champion
FROM athletics_gold
ORDER BY event ASC, gender ASC, year ASC;
