-- Netflix Project
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix 
(
show_id	varchar(6),
type	varchar(10),
title	varchar(150),
director	varchar(208),
casts	varchar(1000),
country	  varchar(150),
date_added	varchar(50),
release_year	int,
rating	varchar(10),
duration	varchar(15),
listed_in	varchar(100),
description  varchar(250)
);

SELECT COUNT(*) as total_content
from netflix;

-- Business Problems 

-- 1. Count the number of Movies vs TV Shows

SELECT 
    type,
	count(*) as Total_content
from netflix
GROUP BY type



-- 2. Find the most common rating for movies and TV shows

	SELECT
	  type,
	  rating
	from
	 (
     SELECT 
	       type,
		   rating,
		   count(*),
		   rank() over(partition by type order by count(*) desc) as ranking
     from netflix
	 group by 1,2
	 ) as t1
	where 
	ranking = 1

3. List all movies released in a specific year (e.g., 2020)

   SEL-- Netflix Project
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix 
(
show_id	varchar(6),
type	varchar(10),
title	varchar(150),
director	varchar(208),
casts	varchar(1000),
country	  varchar(150),
date_added	varchar(50),
release_year	int,
rating	varchar(10),
duration	varchar(15),
listed_in	varchar(100),
description  varchar(250)
);

SELECT COUNT(*) as total_content
from netflix;
SELECT DISTINCT type
from netflix;

SELECT * FROM netflix;

-- Business Problems 

-- 1. Count the number of Movies vs TV Shows

SELECT 
    type,
	count(*) as Total_content
from netflix
GROUP BY type



-- 2. Find the most common rating for movies and TV shows

	SELECT
	  type,
	  rating
	from
	 (
     SELECT 
	       type,
		   rating,
		   count(*),
		   rank() over(partition by type order by count(*) desc) as ranking
     from netflix
	 group by 1,2
	 ) as t1
	where 
	ranking = 1

-- 3. List all movies released in a specific year (e.g., 2020)

	SELECT type,
	       title,
		   release_year
     from netflix
	 where type = 'Movie' AND release_year = '2020';



-- 4. Find the top 5 countries with the most content on Netflix

   SELECT 
          TRIM(UNNEST(STRING_TO_ARRAY(country,','))) as New_Country,
          count(show_id) as Total_content
		  FROM netflix
   group by 1
   order by total_content DESC
   limit 5;

		  
-- 5. Identify the longest movie

SELECT 
    type,
    title,
    SPLIT_PART(duration, ' ', 1)::int AS duration_number
FROM netflix
WHERE 
    type = 'Movie'
    AND SPLIT_PART(duration, ' ', 1)::int = (
        SELECT MAX(SPLIT_PART(duration, ' ', 1)::int)
        FROM netflix
        WHERE type = 'Movie'
    );



-- 6. Find content added in the last 5 years
  
SELECT *
FROM netflix
WHERE 
TO_DATE(date_added, 'Month DD,YYYY') >= CURRENT_DATE - INTERVAL '5 years'
;

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

	Select title,
	       type,
		   director
    from netflix
	where director = 'Rajiv Chilaka';



-- 8. List all TV shows with more than 5 seasons

    SELECT title,
	       type,
		   SPLIT_PART(duration, ' ', 1)::int AS duration_number
		 from netflix
    WHERE type = 'TV Show'
	AND 
	SPLIT_PART(duration, ' ', 1)::int > 5
	order by duration_number DESC;
		   
-- 9. Count the number of content items in each genre

	SELECT 
	      trim(genre) as genre,
		  count(*) as count
	from netflix,
	lateral unnest(string_to_array(listed_in, ',')) as genre
	group by trim(genre)
	order by count DESC;

-- 10.Find each year and the average numbers of content release in India on netflix.Return top 5 year with highest content release.

-- You can't use a SELECT alias in the WHERE clause,
-- but you can use a LATERAL alias anywhere because it's part of the FROM clause and treated as a real column from that moment on.

 SELECT 
  TRIM(c) AS country,
  release_year,
  COUNT(*) AS total_count,
  COUNT(*)::numeric / (
    SELECT COUNT(*) 
    FROM netflix, 
    LATERAL UNNEST(STRING_TO_ARRAY(country, ',')) AS c2 
    WHERE TRIM(c2) = 'India'
  ) * 100 AS avg_release_percent
FROM netflix,
LATERAL UNNEST(STRING_TO_ARRAY(country, ',')) AS c
WHERE TRIM(c) = 'India'
GROUP BY TRIM(c), release_year
ORDER BY total_count DESC
LIMIT 5;

-- 11. List all movies that are documentaries
      
SELECT * FROM netflix
where 
    listed_in ILIKE '%documentaries%'; 
   
-- 12. Find all content without a director

   SELECT * FROM netflix
   where director is null;
	

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

     SELECT * FROM netflix
	 where 
	 casts ILIKE '%Salman Khan%'
	 AND release_year >= extract(year from current_date)-10;
	 
-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

    SELECT
  TRIM(actor) AS actor,
  COUNT(*) AS count
FROM netflix,
  LATERAL unnest(string_to_array(casts, ',')) AS actor
WHERE country = 'India'
GROUP BY TRIM(actor)
ORDER BY count DESC
limit  10;

	 
-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. 
--Label content containing these keywords as 'Bad' and all other 
--content as 'Good'. Count how many items fall into each category.

-- CASE WHEN statement to categorize each row, and then count using GROUP BY
-- END AS category is part of the CASE statement in SQL
   
  SELECT
  CASE
    WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
    ELSE 'Good'
  END AS category,
  COUNT(*) AS count
FROM netflix
GROUP BY category;

-- 16 Which directors have created the most content across all genres?

   SELECT     
          director,
    count (*) as Total_content
 FROM netflix
    where director is not null
	group by director
	order by Total_content desc
	limit 10;
    
-- 17 Find the average duration of Movies per genre

	SELECT 
    TRIM(genre) AS genre,
	avg(SPLIT_PART(duration, ' ', 1)::int) as Average_duration
FROM 
    netflix,
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre
	where type = 'Movie'
	AND duration IS NOT NULL
    AND duration ILIKE '%min%'
    AND listed_in IS NOT NULL
	group by trim(genre)
	order by average_duration DESC;

-- 18 Which months have the highest number of releases?

    SELECT 
           EXTRACT(MONTH FROM TO_DATE(date_added, 'Month DD, YYYY')) AS month_added,
	       count (*) as Total_content
 from netflix
   where 
   (Select  
   EXTRACT(MONTH FROM TO_DATE(date_added, 'Month DD, YYYY')) is not null)
  group by month_added
  order by month_added;

-- 19 Top 10 titles with the longest time gap between release and being added to Netflix

      SELECT title,release_year,
	         EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS Year_added,
			 EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) - release_year as Time_gap_in_years
	  FROM netflix
	  WHERE date_added IS NOT NULL AND release_year IS NOT NULL
	  order by time_gap_in_years desc
	  limit 10;

-- 20 Which genre has the most  content added in the latest year(2021)?
   
   SELECT 
         trim (genre) as genre,
		 count (*) as Total_content
	FROM 
		 netflix,
		 UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre
    where 
	     EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) = 2021 
		 AND  date_added IS NOT NULL
		 group by trim(genre)
		 ORDER BY total_content DESC
		 limit 10;
   


   
  
