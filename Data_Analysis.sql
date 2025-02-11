-- 1. Count the number of Movies vs TV Shows
select 
	sum(case when type = 'Movie' then 1 else 0 end) as n_movies,
	sum(case when type = 'TV Show' then 1 else 0 end) as n_shows
from netflix;

-- 2. Find the most common rating for movies and TV shows
select type,rating
from
(
select
	type,
	rating,
	count(rating),
	rank() over(partition by type order by count(rating)desc) as rnk
from netflix
group by 1,2
) sub
where rnk = 1;

-- 3. List all movies released in a specific year (e.g., 2020)
select title
from netflix
where release_year = '2020';

-- 4. Find the top 5 countries with the most content on Netflix
select country
from
(
select trim(unnest(string_to_array(country,','))) as country,
count(*) as total_content,
rank() over(order by count(*) desc) as rank
from netflix
where country is not null
group by 1
) sub
where rank <= 5;

-- 5. Identify the longest movie
select title as "Longest_Movie"
from
(
select 
	title, 
	duration,
	cast(regexp_replace(duration, '[^0-9]', '', 'g') as integer) as duration_num,
	rank() over(order by cast(regexp_replace(duration, '[^0-9]', '', 'g') as integer) desc) as rnk
from netflix
where type = 'Movie' and duration is not null
) sub
where rnk = 1;

-- 6. Find content added in the last 5 years
-- Last 5 years relative to maximum year in the dataset
select * from netflix
where release_year >=
(select max(release_year) - 4 from netflix)
order by release_year desc;
-- Last 5 year relative to today
select * from netflix
where release_year >= extract(year from current_date) - 4
order by release_year desc;

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select title, type, director_name
from 
(
select 
	title, 
    type, 
    unnest(string_to_array(director, ',')) as director_name
from netflix
) sub
where director_name ilike 'rajiv chilaka';

-- 8. List all TV shows with more than 5 seasons
select title, duration
from
(
select 
	title, 
	duration,
	cast(regexp_replace(duration, '[^0-9]', '', 'g') as integer) as n_seasons
from netflix
where duration not in
(select duration from netflix where duration ilike '%min%')
) sub
where n_seasons > 5;

-- 9. Count the number of content items in each genre
select
	trim(unnest(string_to_array(listed_in, ','))) as genre,
	count(*) as n_items
from netflix
group by 1
order by 2 desc;

-- 10.Find each year and the average numbers of content release in India on netflix.
-- Return top 5 year with highest avg content release
with country_releases as 
(
select 
	release_year,
	trim(unnest(string_to_array(country,','))) as country_name,
	count(*) as n_items
from netflix
group by release_year,country_name
),
avg_releases as 
(
select 
	release_year,
	cast(avg(n_items) over(partition by release_year) as integer) as n_releases
from country_releases
where country_name = 'India'
),
avg_ranked as 
(
select 
	release_year,
	n_releases,dense_rank() over(order by n_releases desc) as rnk 
from avg_releases
)
select release_year,n_releases
from avg_ranked
where rnk <= 5;

-- 11. List all movies that are documentaries
select *
from
(
select 
	*,
	trim(unnest(string_to_array(listed_in,','))) as genre
from netflix
where type = 'Movie'
) sub
where genre = 'Documentaries';

-- 12. Find all content without a director
select *
from netflix
where director is null;

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years
select count(*)
from
(
select title, "casts", release_year
from netflix
where 
	"casts" ilike '%Salman Khan%' and
	release_year >= (select max(release_year) - 10 from netflix) and
	type = 'Movie'
group by 1,2,3
) sub;
-- Last 10 years from today
select count(*)
from
(
select title, "casts", release_year
from netflix
where 
	"casts" ilike '%Salman Khan%' and
	release_year >= extract(year from current_date) - 10 and
	type = 'Movie'
group by 1,2,3
) sub;

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in US.
with movie_lists as
(
select
	trim(unnest(string_to_array("casts", ','))) as actor_name,
	trim(unnest(string_to_array(country, ','))) as country_name
from netflix
where type = 'Movie'
),
us_movies as
(
select 
	actor_name, 
	count(*) as n_appearances,
	rank() over(order by count(*) desc) as rnk
from movie_lists
where country_name = 'United States' and actor_name is not null
group by 1
)
select actor_name, n_appearances
from us_movies
where rnk <= 10;

-- 15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. 
-- Label content containing these keywords as 'Content_Warning' and all other content as 'No_Content_Warning'. 
-- Count how many items fall into each category.
select content_filter, count(*) as n_items
from
(
select 
	title,
	case 
		when description ilike '%kill%' or description ilike '%violence%' then 'Content_Warning'
		else 'No_Content_Warning' 
	end as content_Filter
from netflix
) sub
group by 1;