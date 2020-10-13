/* 
Find the titles of all movies directed by Steven Spielberg.
*/
SELECT title FROM Movie WHERE director = "Steven Spielberg";
/*
Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.

*/
SELECT DISTINCT year FROM Rating JOIN Movie USING(mID)
	WHERE stars == 4 or stars = 5
	ORDER BY year;

/*
Find the titles of all movies that have no ratings.

*/
SELECT title FROM Movie
	WHERE mID not in (SELECT mID FROM Rating)
	ORDER BY year;
/*
Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.
*/
SELECT name FROM Rating JOIN Reviewer USING(rID) WHERE ratingDate is NULL
/*Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.*/

SELECT name , title, stars, ratingDate FROM (Movie JOIN Rating USING(mID)) JOIN Reviewer USING(rID)
ORDER BY name, title, stars
/*
For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.
*/
SELECT DISTINCT name , title FROM (Movie JOIN Rating USING(mID)) JOIN Reviewer USING(rID)
WHERE rID in (SELECT R1.rID FROM Rating as R1 , Rating as R2 
WHERE R1.rID = R2.rID and R1.mID = R2.mID and R1.stars < R2.stars and R1.ratingDate < R2.ratingDate)
/*
For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.
*/
SELECT title , max(stars) FROM Movie JOIN Rating USING(mID) 
GROUP BY mID
ORDER BY title
/*
For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title.
*/
SELECT title , max(stars) - min(stars) as ratingSpread  FROM Movie JOIN Rating USING(mID) 
GROUP BY mID
ORDER BY ratingSpread DESC, title
/*
Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.)
*/
SELECT avgBefore - avgAfter FROM
(SELECT avg(avgRate) as avgBefore FROM
(SELECT mID, avg(stars) as avgRate FROM Rating
GROUP BY mID) JOIN Movie USING(mID)
WHERE year < 1980 )
,
(SELECT avg(avgRate) as avgAfter FROM
(SELECT mID, avg(stars) as avgRate FROM Rating
GROUP BY mID) JOIN Movie USING(mID)
WHERE year > 1980) as a
