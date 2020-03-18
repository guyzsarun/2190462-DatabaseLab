INSERT INTO Professor (pid, pname, salary)
VALUES ('001', 'Michael', '35000'),
('002', 'Simon', '40000'),
('003', 'William', '25000'),
('004', 'Ken', '40000'),
('005', 'Steve', '50000');

INSERT INTO Student (student_id, name , year , email)
VALUES ('57723547', 'Jasmine', '1', '57723547@student.chula.ac.th'),
('57712358', 'Lotus', '1', '57712358@student.chula.ac.th'),
('56756421', 'Orchid', '2', '56756421@student.chula.ac.th'),
('56717931', 'Rose', '2', '56717931@student.chula.ac.th'),
('55748896', 'Tulip', '3', '55748896@student.chula.ac.th'),
('55489317', 'Zinnia', '3', '55489317@student.chula.ac.th'),
('60318515','Sarun','3','6031851521@student.chula.ac.th');

INSERT INTO Course (cid , title , dept_name , credits)
VALUES ('101001', 'Physics', 'Science', '3'),
('101002', 'Mathematics', 'Science', '3'),
('201001', 'Programming', 'Computer Engineering','2'),
('201002', 'Database Systems', 'Computer Engineering','3'),
('301001', 'Software Engineering', 'Computer Engineering','3');

INSERT INTO Section (cid , sect_id , semester , year , building , room , timeslot_id) VALUES 
('101001', '1','1','2015','SCI 03','512','1'),
('101002', '1','1','2015','SCI 28','418','2'),
('101002', '2','1','2015','SCI 28','317','3'),
('201001', '1','summer','2015','Eng 3','305','3'),
('201001', '2','summer','2015','Eng 3','405','3'),
('201001', '3','summer','2015','Eng 3','309','1'),
('201002', '1','2','2015','Eng 100','405','2'),
('301001', '1','2','2015','Eng 3','309','2'),
('301001', '2','2','2015','Eng 3','305','1');


#INSERT INTO Section (cid , sect_id , semester , year , building , room , timeslot_id)
#VALUES ('401001', '1','1','2015','SCI 03','512','1');

INSERT INTO Teaches (pid,cid,sect_id,semester,year) VALUES
('001','101001','1','1','2015'),
('002','101002','1','1','2015'),
('002','101002','2','1','2015'),
('004','201002','1','2','2015'),
('005','301001','1','2','2015'),
('005','301001','2','2','2015'),
('003','201001','1','summer','2015'),
('003','201001','2','summer','2015'),
('003','201001','3','summer','2015');

INSERT INTO Takes (student_id,cid,sect_id,semester,year,grade) VALUES
('57723547','101001','1','1','2015','A'),
('57712358','101001','1','1','2015','A'),
('57723547','101002','1','1','2015','B+'),
('57712358','101002','2','1','2015','B'),
('56756421','201001','1','summer','2015','A'),
('56717931','201001','3','summer','2015','B'),
('55748896','201002','1','2','2015','A'),
('55489317','301001','2','2','2015','C');



