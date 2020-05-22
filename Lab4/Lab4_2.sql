# 5.1
CREATE TRIGGER new_professor_added
AFTER INSERT ON Professor
FOR EACH ROW
insert into faculty_insurance (ref_id,ins_plan, credit_limit,duedate,s_timestamp,status)
values (new.pid,"Group Insurance for Instructor",new.salary*3,DATE_ADD(SYSDATE(),
INTERVAL 4
YEAR),SYSDATE(),'A');

INSERT INTO Professor (pid,pname,salary) VALUES ('123','foo',1000);
UPDATE Professor SET salary = 25000 WHERE pid = '003';

SELECT * FROM Professor;
SELECT * FROM faculty_insurance;

#5.2
DELIMITER $$
CREATE FUNCTION fn_currency(input_number DECIMAL, exchange_rate DECIMAL,currency_name VARCHAR (60))
RETURNS
varchar(50)
DETERMINISTIC
BEGIN
DECLARE currency varchar(50);
SET currency = CONCAT(CONCAT(input_number/exchange_rate,' '),currency_name);
RETURN currency;
END$$
DELIMITER ;

select fn_currency (70,35.00,'USD');
select *, fn_currency (70,35.00 ,'USD') from Professor;

#5.3
DELIMITER $$
DROP PROCEDURE IF EXISTS Proc_cal_professor_upvel;
CREATE PROCEDURE Proc_cal_professor_upvel()
DETERMINISTIC
BEGIN
if(select COUNT(salary) from Professor where salary<30000)>0 THEN
CREATE TEMPORARY TABLE IF NOT EXISTS TMP_PROFESSOR(PID varchar(16),salary INT,credit_limit DECIMAL(10,2));
TRUNCATE TABLE TMP_PROFESSOR;

insert into TMP_PROFESSOR (PID,salary,credit_limit) 
select DISTINCT pid,salary,credit_limit from Professor JOIN faculty_insurance ON pid=ref_id where salary<30000;

update Professor set salary=salary*1.1 where pid IN (select PID from TMP_PROFESSOR);
update faculty_insurance JOIN Professor ON pid=ref_id set credit_limit=salary*4 WHERE ref_id IN (SELECT PID FROM TMP_PROFESSOR);

INSERT INTO system_log (user_log, remark,timestamp)
select t.PID, CONCAT('old salary ',t.salary,' new salary ',p.salary,' old credit ',t.credit_limit,' new credit ',f.credit_limit), SYSDATE() from TMP_PROFESSOR t JOIN Professor p ON p.pid=t.PID JOIN faculty_insurance f ON ref_id=p.pid;

SELECT t.PID,pname,t.salary,p.salary,t.credit_limit,f.credit_limit,SYSDATE() FROM TMP_PROFESSOR t JOIN Professor p ON t.PID=p.pid JOIN faculty_insurance f ON ref_id=p.pid;
ELSE
select ' <30000 is empty';
END IF;
END$$
DELIMITER ;

SELECT * FROM system_log;

SELECT * FROM faculty_insurance;

SELECT * FROM Professor;

Call Proc_cal_professor_upvel();