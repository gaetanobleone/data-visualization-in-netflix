/*
The early stages of the process conisted of setting up a databse titled "netlfix", and a table titled "media" to the store data. 
The data used in this process had been pulled from an external site (i.e., "https://www.kaggle.com/datasets/rahulvyasm/netflix-movies-and-tv-shows").
*/

CREATE DATABASE netflix;

CREATE TABLE media (
	show_id text, --a unique identifier
	type text, --the category of entertainment; that is either movie or tv show
	title text, --the name of the movie or tv show
	director text, --the directors of the movie or tv show
	actors_and_actresses text, --a list of main actors/actresses in the movie or tv show
	country text, --the country or countries where production took place
	date_added text, --the date the title had been added to "netlfix"
	release_year int, --the year the release of the movie or tv show occured
	rating text, --the age rating
	duration text, --the duration of the movie or tv show in minutes for movies, and seasons for tv shows
	listed_in text, --the genres that are associated with the tv show or movie
	description text --a summary of the tv show or movie  
);

/* 
I then proceeded to import the "cleaned" dataset. 
In the inital process, there were issues with trailing commas in the "uncleaned" dataset, that is after row-12. 
I addressed through the creation of a script in Python, utilizing the "csv" library (i.e., "https://docs.python.org/3/library/csv.html") 
-to "read" and "write" a "cleaned" dataset withut the trailing commas. The file name of the script is titled "data_cleaning_script".
*/

COPY media
FROM 'C:\Users\gaeta\Desktop\sql_project\cleaned_netflix_titles.csv'
WITH (FORMAT CSV, HEADER);

/*
Once the "cleaned" dataset had been imported into the table, I then conducted a quick inspection and 
-identified leading commas in two columns; the "country" column. To rectify this, I updated the columns, removing the leading commas.
*/

BEGIN;

UPDATE media
SET country = REPLACE(country, ', ', '')
WHERE country = ', South Korea';

UPDATE media
SET country = REPLACE(country, ', ', '')
WHERE country = ', France, Algeria';

COMMIT;

/*
The late stages of the process consisted of exporting specific columns (i.e., "title", "country", and "listed_in", etc.) 
-from the "media" table into a new csv file named "exported_data.csv".
*/

SELECT
    CAST(SUM(CASE WHEN country ILIKE '%japan%' THEN 1 ELSE 0 END) AS numeric) / (SELECT count(*) FROM media) * 100 AS japan_result,
    CAST(SUM(CASE WHEN country ILIKE '%united states%' THEN 1 ELSE 0 END) AS numeric) / (SELECT count(*) FROM media) * 100 AS united_states_count,
	CAST(SUM(CASE WHEN country ILIKE '%india%' THEN 1 ELSE 0 END) AS numeric) / (SELECT count(*) FROM media) * 100 AS india_count,
	CAST(SUM(CASE WHEN country ILIKE '%france%' THEN 1 ELSE 0 END) AS numeric) / (SELECT count(*) FROM media) * 100 AS france_count,
	CAST(SUM(CASE WHEN country ILIKE '%canada%' THEN 1 ELSE 0 END) AS numeric) / (SELECT count(*) FROM media) * 100 AS canada_count,
	CAST(SUM(CASE WHEN country ILIKE '%mexico%' THEN 1 ELSE 0 END) AS numeric) / (SELECT count(*) FROM media) * 100 AS mexico_count,
	CAST(SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS numeric) / (SELECT count(*) FROM media) * 100 AS null_count,
	CAST(SUM(CASE WHEN country ILIKE '%south korea%' THEN 1 ELSE 0 END) AS numeric) / (SELECT count(*) FROM media) * 100 AS south_korea_count,
	CAST(SUM(CASE WHEN country ILIKE '%spain%' THEN 1 ELSE 0 END) AS numeric) / (SELECT count(*) FROM media) * 100 AS spain_count,
	CAST(SUM(CASE WHEN country ILIKE '%united kingdom%' THEN 1 ELSE 0 END) AS numeric) / (SELECT count(*) FROM media) * 100 AS united_kingdom_count
FROM media;

-- In the process of running several queries, I noticed some data had been lacking; thus, I made some updates to the data manually...

SELECT count(title), rating
FROM media
WHERE country ILIKE '%united states%'
GROUP BY rating;

BEGIN;

UPDATE media
SET rating = 'NR'
WHERE title = 'Louis C.K. 2017';

UPDATE media
SET duration = '74 min'
WHERE title = 'Louis C.K. 2017';

UPDATE media
SET rating = 'NR'
WHERE title = 'Louis C.K.: Live at the Comedy Store';

UPDATE media
SET duration = '66 min'
WHERE title = 'Louis C.K.: Live at the Comedy Store';

UPDATE media
SET rating = 'NR'
WHERE title = 'Louis C.K.: Hilarious';

UPDATE media
SET duration = '84 min'
WHERE title = 'Louis C.K.: Hilarious';

COMMIT;

-- list the count of ratings of titles that come from the United States

SELECT CAST(count(title) AS numeric) / (SELECT count(title) FROM media WHERE country ILIKE '%united states%') AS united_states_rating_percentage, 
	rating
FROM media
WHERE country ILIKE '%united states%'
GROUP BY rating;

-- list the count of ratings of titles that come from Japan

SELECT CAST(count(title) AS numeric) / (SELECT count(title) FROM media WHERE country ILIKE '%japan%') AS japan_rating_percentage, 
	rating
FROM media
WHERE country ILIKE '%japan%'
GROUP BY rating;


