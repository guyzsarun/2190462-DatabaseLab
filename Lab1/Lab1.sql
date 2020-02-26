#CREATE DATABASE Registration;

USE Registration;

CREATE table professor (
    pid VARCHAR (8) NOT NULL PRIMARY KEY,
    pname VARCHAR(256) NOT NULL,
    salary INT NOT NULL
);

INSERT INTO professor (pid,pname,salary) VALUES ('001','Micheal',35000),
                                                ('002','Simon',42000),
                                                ('003','William',25000),
                                                ('004','Ken','40000'),
                                                ('005','Steve','50000');

INSERT INTO professor (pid,pname,salary) VALUES ('006','Sarun',27000);

SELECT * FROM professor;