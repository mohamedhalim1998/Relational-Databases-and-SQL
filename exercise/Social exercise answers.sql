
/*
Find the names of all students who are friends with someone named Gabriel.
*/
SELECT name FROM Highschooler 
WHERE Highschooler.ID in (SELECT ID1 FROM Friend ,Highschooler WHERE Highschooler.ID = Friend.ID2 and Highschooler.name = "Gabriel")

/*
For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like.
*/
SELECT S1.name , S1.grade ,S2.name , S2.grade FROM Likes , Highschooler S1, Highschooler S2
WHERE Likes.ID1 = S1.ID and Likes.ID2 = S2.ID
and S1.grade - S2.grade > 1

/*
For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order.
*/

SELECT DISTINCT S1.name , S1.grade , S2.name , S2.grade FROM Likes L1 , Likes L2, Highschooler S1, Highschooler S2 
WHERE L1.ID1 = L2.ID2 and L2.ID1 = L1.ID2 and S1.ID = L1.ID1 and S2.ID = L1.ID2 and S1.name < S2.name
/*
Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade.
*/
SELECT name , grade FROM Highschooler 
WHERE Highschooler.ID not in (SELECT ID1 FROM Likes) AND Highschooler.ID not in (SELECT ID2 FROM Likes)
ORDER BY grade , name
/*
For every situation where student A likes student B, but we have no information about whom B likes
 (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades.
*/

SELECT DISTINCT S1.name , S1.grade , S2.name , S2.grade FROM Likes L, Highschooler S1, Highschooler S2 
WHERE L.ID2 NOT IN (SELECT ID1 FROM Likes) and S1.ID = L.ID1 and S2.ID = L.ID2

/*
Find names and grades of students who only have friends in the same grade. Return the result sorted by grade,
then by name within each grade.
*/
SELECT name , grade FROM Highschooler S1
WHERE S1.ID NOT IN (SELECT S1.ID FROM Highschooler S2 , Friend WHERE S1.ID = Friend.ID1 and S2.ID = Friend.ID2 and S1.grade <> S2.grade)
ORDER BY grade , name

/*
For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). 
For all such trios, return the name and grade of A, B, and C.
*/
SELECT S1.name , S1.grade, S2.name ,S2.grade, S3.name ,S3.grade FROM Highschooler S1, Highschooler S2 , Highschooler S3, Likes
WHERE S1.ID = Likes.ID1 and S2.ID = Likes.ID2 and S2.ID not in (SELECT ID2 FROM Friend WHERE S1.ID = Friend.ID1 and S2.ID = Friend.ID2)
AND S3.ID in (SELECT ID2 FROM Friend WHERE S1.ID = Friend.ID1 and S3.ID = Friend.ID2)
AND S3.ID in (SELECT ID2 FROM Friend WHERE S2.ID = Friend.ID1 and S3.ID = Friend.ID2)

/*
Find the difference between the number of students in the school and the number of different first names.
*/
SELECT a-b FROM
(SELECT count(*) as a FROM Highschooler),
(SELECT count(DISTINCT name) as b FROM Highschooler)

/*
Find the name and grade of all students who are liked by more than one other student.
*/

SELECT name, grade
FROM Highschooler, Likes 
WHERE Highschooler.ID = Likes.ID2
GROUP BY ID2
