DROP DATABASE IF EXISTS REGISTRATION_DB;

CREATE DATABASE REGISTRATION_DB;

USE REGISTRATION_DB;

CREATE TABLE Professor (
pid VARCHAR(8) NOT NULL,
pname VARCHAR(256) NOT NULL,
salary INT NOT NULL,
PRIMARY KEY (pid));

CREATE TABLE Student (
student_id VARCHAR(16) NOT NULL,
name VARCHAR(256) NOT NULL,
year INT NOT NULL ,
email VARCHAR(256),
PRIMARY KEY (student_id));

CREATE TABLE Course (
cid VARCHAR(8) NOT NULL ,
title VARCHAR(256) NOT NULL ,
dept_name VARCHAR(256) NOT NULL ,
credits INT NOT NULL ,
PRIMARY KEY (cid)) ;

CREATE TABLE Section (
cid VARCHAR(8) NOT NULL ,
sect_id VARCHAR(8) NOT NULL ,
semester VARCHAR(16) NOT NULL,
year YEAR NOT NULL,
building VARCHAR(256) NOT NULL,
room VARCHAR(16) NOT NULL ,
timeslot_id VARCHAR(8) NOT NULL ,
PRIMARY KEY (cid , sect_id , semester , year),
FOREIGN KEY (cid) REFERENCES Course (cid));

CREATE TABLE Teaches (
pid VARCHAR(8) NOT NULL,
cid VARCHAR(8) NOT NULL,
sect_id VARCHAR(8) NOT NULL,
semester VARCHAR(16) NOT NULL,
year YEAR NOT NULL,
PRIMARY KEY (pid,cid,sect_id,semester,year),
FOREIGN KEY (pid) REFERENCES Professor (pid),
FOREIGN KEY (cid,sect_id,semester,year) REFERENCES Section(cid,sect_id,semester,year));

CREATE TABLE Takes(
student_id VARCHAR (16) NOT NULL,
cid VARCHAR(8) NOT NULL,
sect_id VARCHAR(8) NOT NULL,
semester VARCHAR(16) NOT NULL,
year YEAR NOT NULL,
grade VARCHAR(4),
PRIMARY KEY (student_id,cid,sect_id,semester,year),
FOREIGN KEY (student_id) REFERENCES Student (student_id),
FOREIGN KEY (cid,sect_id,semester,year) REFERENCES Section(cid,sect_id,semester,year)
);

