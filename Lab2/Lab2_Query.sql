#4.1
SELECT DISTINCT Course.cid,title,dept_name,CONCAT(semester,'/',year) AS semester FROM Course 
JOIN Section ON Course.cid = Section.cid WHERE year='2015' AND semester='2';

#4.2
SELECT DISTINCT Professor.pid,pname FROM Professor JOIN Teaches 
ON Professor.pid=Teaches.pid AND semester='summer' AND year='2015';

#4.3
SELECT pname,salary FROM Professor WHERE salary=(SELECT MAX(salary) FROM Professor);

SELECT pname,salary FROM Professor ORDER BY salary DESC LIMIT 1;

#4.4
SELECT building,room,timeslot_id FROM Section JOIN Course 
WHERE Course.cid=Section.cid AND semester='1' AND year='2015';

#4.5
SELECT COUNT(*) AS '#SecondYear' FROM Student WHERE year='2';


#5
CREATE TABLE NoStudent SELECT  * FROM Teaches WHERE 1=2;

INSERT INTO NoStudent SELECT Teaches.pid,Teaches.cid,Teaches.sect_id,Teaches.semester,Teaches.year FROM Teaches 
LEFT JOIN Takes ON Teaches.cid=Takes.cid AND Teaches.sect_id=Takes.sect_id AND Teaches.semester=Takes.semester 
AND Teaches.year=Takes.year WHERE student_id IS NULL;

SELECT * FROM NoStudent;

SELECT * FROM Teaches;
#DEL ROWS
DELETE t FROM Teaches t JOIN NoStudent n ON t.pid=n.pid AND t.cid=n.cid AND t.sect_id=n.sect_id 
AND t.semester=n.semester AND t.year=n.year;

#Check Old Table
#SELECT Teaches.pid,Teaches.cid,Teaches.sect_id,Teaches.semester,Teaches.year FROM Teaches 
#LEFT JOIN Takes ON Teaches.cid=Takes.cid AND Teaches.sect_id=Takes.sect_id AND Teaches.semester=Takes.semester 
#AND Teaches.year=Takes.year WHERE student_id IS NULL;

DROP TABLE NoStudent;