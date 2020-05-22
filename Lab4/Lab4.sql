use lab7;

CREATE TABLE IF NOT EXISTS `faculty_insurance` (
`ref_id` char(16) NOT NULL primary key,
`ins_plan` varchar(50) NOT NULL,
`credit_limit` decimal(10,2) DEFAULT NULL,
`duedate` date DEFAULT NULL,
`s_timestamp` datetime DEFAULT NULL,
`status` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET= utf8mb4;



insert into faculty_insurance (ref_id, ins_plan, credit_limit, duedate, s_timestamp,status)
select pid,'initial value by system',40000,DATE_ADD(SYSDATE(), INTERVAL 4
YEAR),SYSDATE(),'A' from Professor;


insert into faculty_insurance (ref_id,ins_plan, credit_limit,duedate,s_timestamp,status)
select student_id,'initial value by system',20000,DATE_ADD(SYSDATE(), INTERVAL 4
YEAR),SYSDATE(),'A' from Student;


CREATE TRIGGER new_student_added
AFTER INSERT ON Student
FOR EACH ROW
insert into faculty_insurance (ref_id,ins_plan, credit_limit,duedate,s_timestamp,status)
values (new.student_id,"Group Insurance for Student",100000,DATE_ADD(SYSDATE(),
INTERVAL 4
YEAR),SYSDATE(),'A');


insert into Student (student_id,name,year,email)
values ('5971452321','Somechai Rakchad', '1','Somechai@yahoo.com');

SELECT * FROM faculty_insurance where ref_id="5971452321";



DELIMITER $$
CREATE FUNCTION CONCATSTUDENT(student_ID varchar(15), lname varchar(30))
RETURNS
varchar(50)
DETERMINISTIC
BEGIN
DECLARE fullname varchar(50);
SET fullname = CONCAT(CONCAT(student_ID,' '),lname);
RETURN fullname;
END$$
DELIMITER ;


SELECT CONCATSTUDENT('5971463821','Honda Fukumika') as CONCAT_ID_NAME_RESULT;

SELECT CONCATSTUDENT(student_id,name) as CONCAT_ID_NAME_RESULT,email,student_status From Student;

alter table Student add column student_status char(1);

CREATE TABLE IF NOT EXISTS system_log (
`id` int UNSIGNED AUTO_INCREMENT PRIMARY KEY,
`user_log` varchar(50) default NULL,
`remark` varchar(100) default NULL,
`timestamp` datetime default NULL);

SELECT * FROM Student;


DELIMITER $$
CREATE PROCEDURE Proc_flag_student()
DETERMINISTIC
BEGIN
if(select student_id from Takes where grade='F')>0 THEN
CREATE TEMPORARY TABLE IF NOT EXISTS TMP_STUDENT(SID varchar(16));
Truncate table TMP_STUDENT;
insert into TMP_STUDENT (SID) select DISTINCT student_id from Takes where grade='F';
update faculty_insurance set status='N' where ref_id in (select SID from TMP_STUDENT);
update Student set student_status='P' where student_id in (select SID from TMP_STUDENT);
INSERT INTO system_log (user_log, remark,timestamp)
select SID, 'get F', SYSDATE() from TMP_STUDENT;
select * from Student where student_id in (select SID from TMP_STUDENT);
ELSE
select ' F grade is empty';
END IF;
END$$
DELIMITER ;


update Takes set grade='F' where student_id=55748896 and cid=201002;

Call Proc_flag_student()