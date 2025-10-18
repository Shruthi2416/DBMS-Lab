create table person (
driver_id varchar(10),
name varchar(20),
address varchar(30),
primary key(driver_id));

desc person

create table car(
reg_num varchar(10),
model varchar(10),
year int,
primary key(reg_num));

desc car

create table accident(
report_num int, 
accident_date date, 
location varchar(20),
primary key(report_num));

desc accident

create table owns(
driver_id varchar(10),
reg_num varchar(10),
primary key(driver_id, reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num));

desc owns

create table participated(
driver_id varchar(10), 
reg_num varchar(10),
report_num int, 
damage_amount int,
primary key(driver_id, reg_num, report_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num));

desc participated

insert into person values
('A01','Richard','Srinivas Nagar'),
('A02','Pradeep','Rajajinagar'),
('A03','Smith','Ashoknagar'),
('A04','Venu','N.R.Colony'),
('A05','John','Hanumanth Nagar');

select * from person;

insert into car values
('KA052250', 'Indica', 1990),
('KA031181', 'Lancer', 1957),
('KA095477', 'Toyota', 1998),
('KA053408', 'Honda', 2008),
('KA041702', 'Audi', 2005);

select * from car;

insert into accident values
(11,'2003-01-01', 'Mysore Road'),
(12,'2004-02-02','Southend Circle'),
(13,'2003-01-21', 'Bulltemple Road'),
(14,'2008-02-17', 'Mysore Road'),
(15,'2005-03-04', 'Kanakpura Road');

select * from accident;

insert into owns values
('A01', 'KA052250'),
('A02', 'KA053408'),
('A04', 'KA031181'),
('A03', 'KA095477'),
('A05', 'KA041702');

select * from owns;

insert into participated values
('A01', 'KA052250', 11, 10000),
('A02', 'KA053408', 12, 50000),
('A03', 'KA095477', 13, 25000),
('A04', 'KA031181', 14, 3000),
('A05', 'KA041702', 15, 5000);

select * from participated;

update participated set damage_amount=25000 where reg_num='KA053408'and report_num=12;
commit;
select * from participated;

insert into accident values(16,'2008-03-15','Domlur');
select * from accident;

select accident_date, location
from accident;

select driver_id
from participated
where damage_amount>=25000;

SELECT * FROM CAR
ORDER BY year ASC;

SELECT COUNT(report_num) AS accident_count
FROM CAR c, PARTICIPATED p
WHERE c.reg_num = p.reg_num
AND c.model = 'Lancer';

SELECT COUNT(DISTINCT driver_id) AS CNT
FROM PARTICIPATED a, ACCIDENT b
WHERE a.report_num = b.report_num
AND b.accident_date LIKE '__08%';

SELECT * FROM PARTICIPATED
ORDER BY damage_amount DESC;

SELECT AVG(damage_amount)
FROM PARTICIPATED;

DELETE FROM PARTICIPATED
WHERE damage_amount < (
  SELECT avg_damage
  FROM (
    SELECT AVG(damage_amount) AS avg_damage
    FROM PARTICIPATED
  ) AS temp
);

SELECT NAME FROM PERSON A, PARTICIPATED B 
WHERE A.DRIVER_ID = B.DRIVER_ID 
AND DAMAGE_AMOUNT>(SELECT AVG(DAMAGE_AMOUNT) 
FROM PARTICIPATED);


SELECT MAX(damage_amount) AS max_damage
FROM PARTICIPATED;

SELECT accident_date, location
FROM ACCIDENT;

SELECT p.name AS driver_name, c.reg_num, c.model, c.year
FROM PERSON p
JOIN OWNS o ON p.driver_id = o.driver_id
JOIN CAR c ON o.reg_num = c.reg_num;

SELECT a.report_num, a.accident_date, a.location,
       p.name AS driver_name, pa.damage_amount
FROM ACCIDENT a
JOIN PARTICIPATED pa ON a.report_num = pa.report_num
JOIN PERSON p ON pa.driver_id = p.driver_id
ORDER BY a.report_num;

SELECT report_num, SUM(damage_amount) AS total_damage
FROM PARTICIPATED
GROUP BY report_num;

SELECT driver_id, COUNT(DISTINCT report_num) AS accident_count
FROM PARTICIPATED
GROUP BY driver_id
HAVING COUNT(DISTINCT report_num) > 1;

SELECT c.reg_num, c.model, c.year
FROM CAR c
WHERE c.reg_num NOT IN (
  SELECT DISTINCT reg_num FROM PARTICIPATED
);

SELECT *
FROM ACCIDENT
WHERE accident_date = (SELECT MAX(accident_date) FROM ACCIDENT);

SELECT driver_id, AVG(damage_amount) AS avg_damage
FROM PARTICIPATED
GROUP BY driver_id;

UPDATE PARTICIPATED
SET damage_amount = 25000
WHERE reg_num = 'KA09AB1234' AND report_num = 101;

SELECT p.name, pa.driver_id, pa.damage_amount
FROM PARTICIPATED pa
JOIN PERSON p ON pa.driver_id = p.driver_id
WHERE pa.damage_amount = (
  SELECT MAX(damage_amount) FROM PARTICIPATED
);

SELECT c.model, SUM(pa.damage_amount) AS total_damage
FROM CAR c
JOIN PARTICIPATED pa ON c.reg_num = pa.reg_num
GROUP BY c.model
HAVING SUM(pa.damage_amount) > 20000;

CREATE VIEW AccidentSummary AS
SELECT a.report_num,
       a.accident_date,
       a.location,
       COUNT(pa.driver_id) AS participants_count,
       SUM(pa.damage_amount) AS total_damage
FROM ACCIDENT a
LEFT JOIN PARTICIPATED pa ON a.report_num = pa.report_num
GROUP BY a.report_num, a.accident_date, a.location;

SELECT * FROM AccidentSummary;










































