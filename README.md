# Netflix Data Analysis Project

## Overview
This project involves analyzing a Netflix dataset using SQL to derive insights about movies and TV shows available on the platform. The dataset contains information such as show type, title, director, cast, country, release year, rating, duration, genres, and more. The queries address various business questions to uncover patterns and trends in the content.

## Dataset
The dataset is stored in a table named `netflix` with the following schema:
- `show_id`: Unique identifier for the show (varchar)
- `type`: Type of content (Movie or TV Show) (varchar)
- `title`: Title of the content (varchar)
- `director`: Director of the content (varchar)
- `casts`: Cast members (varchar)
- `country`: Country of production (varchar)
- `date_added`: Date the content was added to Netflix (varchar)
- `release_year`: Year of release (int)
- `rating`: Content rating (varchar)
- `duration`: Duration of the content (varchar)
- `listed_in`: Genres the content belongs to (varchar)
- `description`: Brief description of the content (varchar)

## Business Questions and Queries
The project includes 25 SQL queries addressing the following business questions:

1. **Count the number of Movies vs TV Shows**: Groups content by type to show total counts.
2. **Find the most common rating for movies and TV shows**: Uses ranking to identify the most frequent rating per content type.
3. **List all movies released in a specific year (e.g., 2020)**: Filters movies by release year.
4. **Find the top 5 countries with the most content**: Splits country strings and counts content per country.
5. **Identify the longest movie**: Finds the movie with the maximum duration.
6. **Find content added in the last 5 years**: Filters content based on the date added.
7. **Find all movies/TV shows by director 'Rajiv Chilaka'**: Retrieves content by a specific director.
8. **List all TV shows with more than 5 seasons**: Filters TV shows by season count.
9. **Count the number of content items in each genre**: Splits genres and counts occurrences.
10. **Find the top 5 years with the highest content release in India**: Calculates release counts and percentages for India.
11. **List all movies that are documentaries**: Filters content with 'documentaries' in genres.
12. **Find all content without a director**: Identifies content with null director values.
13. **Find how many movies actor 'Salman Khan' appeared in the last 10 years**: Filters by actor and release year.
14. **Find the top 10 actors in Indian movies**: Counts actor appearances in Indian content.
15. **Categorize content as 'Bad' or 'Good' based on keywords**: Labels content based on 'kill' or 'violence' in descriptions.
16. **Which directors have created the most content?**: Counts content per director.
17. **Find the average duration of movies per genre**: Computes average movie duration by genre.
18. **Which months have the highest number of releases?**: Groups content by the month added.
19. **Top 10 titles with the longest gap between release and addition**: Calculates the time gap between release and addition.
20. **Which genre has the most content added in 2021?**: Counts genres for content added in 2021.
21. **Average number of seasons for TV shows**: Computes the average season count for TV shows.
22. **Top 10 movies with the shortest duration**: Orders movies by duration.
23. **Movies or shows released each year**: Counts releases per year.
24. **Top 10 directors with the most diverse genre coverage**: Counts unique genres per director.
25. **Actor with the most movie appearances**: Identifies the actor with the highest movie count.

## Key Features
- **Data Cleaning**: Handles comma-separated fields (e.g., country, casts, genres) using `UNNEST` and `STRING_TO_ARRAY`.
- **Advanced SQL**: Utilizes window functions (`RANK`), lateral joins, and string manipulation.
- **Date Handling**: Converts string dates to proper formats using `TO_DATE` for temporal analysis.
- **Pattern Matching**: Uses `ILIKE` for case-insensitive searches in descriptions and genres.

## Prerequisites
- SQL environment (e.g., PostgreSQL, MySQL, or SQLite)
- Netflix dataset loaded into the `netflix` table

## How to Use
1. Create the `netflix` table using the provided `CREATE TABLE` statement.
2. Import the dataset into the table.
3. Run the SQL queries to analyze the data and answer the business questions.

## Example Insights
- Movies dominate the platform compared to TV shows.
- The most common ratings differ between movies and TV shows.
- Certain countries, like the United States and India, contribute significantly to Netflix's content library.
- Documentaries and specific directors like Rajiv Chilaka have a notable presence.
- Content with themes of 'kill' or 'violence' can be categorized for content moderation.

## Future Improvements
- Add visualization of results using tools like Tableau or Python (Matplotlib/Seaborn).
- Expand the dataset to include more recent data.
- Incorporate additional business questions, such as user engagement metrics.

## Author
Shane, Data Science Enthusiast
