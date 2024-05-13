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

UPDATE media
SET country = REPLACE(country, ', ', '')
WHERE country = ', South Korea';

UPDATE media
SET country = REPLACE(country, ', ', '')
WHERE country = ', France, Algeria';

/*
The late stages of the process consisted of exporting specific columns (i.e., "title", "country", and "listed_in") 
-from the "media" table into a new csv file named "exported_data.csv".
*/

COPY(
	SELECT title, country, listed_in
	FROM media
	)
TO 'C:\Users\gaeta\Desktop\sql_project\exported_data.csv'
WITH (FORMAT CSV, HEADER);


