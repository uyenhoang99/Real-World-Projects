SELECT * FROM public.student_performance;

-- avg_exam_score_by_study_and_extracurricular
-- Edit the query below as needed
SELECT hours_studied, AVG(exam_score) AS avg_exam_score
FROM public.student_performance
WHERE hours_studied > 10 AND extracurricular_activities = 'Yes'
GROUP BY hours_studied
ORDER BY avg_exam_score DESC; 

-- avg_exam_score_by_hours_studied_range
-- Add solution code below 
SELECT
CASE WHEN hours_studied BETWEEN 1 AND 5 THEN '1-5 hours'
     WHEN hours_studied BETWEEN 6 AND 10 THEN '6-10 hours'
	 WHEN hours_studied BETWEEN 11 AND 15 THEN '11-15 hours'
	 ELSE '16+ hours' END AS hours_studied_range,
AVG(exam_score) AS avg_exam_score
FROM public.student_performance
GROUP BY hours_studied_range
ORDER BY avg_exam_score DESC;


-- student_exam_ranking
-- Add solution code below 
SELECT attendance, 
	   hours_studied, 
	   sleep_hours, 
	   tutoring_sessions, 
       DENSE_RANK() OVER(ORDER BY exam_score) AS exam_rank
FROM public.student_performance
ORDER BY exam_rank ASC
LIMIT 30;