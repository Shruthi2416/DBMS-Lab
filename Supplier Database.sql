CREATE TABLE Supplier (
    sid INT ,
    sname VARCHAR(50),
    city VARCHAR(50),
    PRIMARY KEY(sid)
);

CREATE TABLE Parts (
    pid INT ,
    pname VARCHAR(50),
    color VARCHAR(30),
    PRIMARY KEY(pid)
);

CREATE TABLE Catalog (
    sid INT,
    pid INT,
    cost DECIMAL(10,2),
    PRIMARY KEY (sid, pid),
    FOREIGN KEY (sid) REFERENCES Supplier(sid),
    FOREIGN KEY (pid) REFERENCES Parts(pid)
);

INSERT INTO Supplier VALUES
(1, 'Acme Widget Suppliers', 'New York'),
(2, 'Global Parts Co', 'Chicago'),
(3, 'TechnoGears Ltd', 'San Francisco'),
(4, 'Precision Supplies', 'Boston'),
(5, 'Universal Components', 'Seattle');

SELECT * FROM Supplier;

INSERT INTO Parts VALUES 
(101, 'Bolt', 'Red'),
(102, 'Nut', 'Blue'),
(103, 'Screw', 'Green'),
(104, 'Washer', 'Red'),
(105, 'Gear', 'Black');

SELECT * FROM Parts;

INSERT INTO Catalog VALUES 
(1, 101, 5.00),
(1, 102, 3.50),
(2, 101, 6.00),
(3, 103, 4.75),
(4, 104, 7.20);

SELECT * FROM Catalog;

SELECT DISTINCT P.pname
FROM Parts P
JOIN Catalog C ON P.pid = C.pid;

SELECT S.sname
FROM Supplier S
WHERE NOT EXISTS (
    SELECT P.pid
    FROM Parts P
    WHERE NOT EXISTS (
        SELECT C.pid
        FROM Catalog C
        WHERE C.sid = S.sid AND C.pid = P.pid));

SELECT S.sname
FROM Supplier S
WHERE NOT EXISTS (
    SELECT P.pid
    FROM Parts P
    WHERE P.color = 'Red' AND NOT EXISTS (
        SELECT C.pid
        FROM Catalog C
        WHERE C.sid = S.sid AND C.pid = P.pid));

SELECT P.pname
FROM Parts P
JOIN Catalog C ON P.pid = C.pid
JOIN Supplier S ON C.sid = S.sid
WHERE S.sname = 'Acme Widget Suppliers'
AND P.pid NOT IN (
    SELECT C2.pid
    FROM Catalog C2
    JOIN Supplier S2 ON C2.sid = S2.sid
    WHERE S2.sname <> 'Acme Widget Suppliers');

SELECT DISTINCT C.sid
FROM Catalog C
WHERE C.cost > (
    SELECT AVG(C2.cost)
    FROM Catalog C2
    WHERE C2.pid = C.pid);

SELECT P.pname, S.sname
FROM Parts P
JOIN Catalog C ON P.pid = C.pid
JOIN Supplier S ON C.sid = S.sid
WHERE (C.pid, C.cost) IN (
    SELECT pid, MAX(cost)
    FROM Catalog
    GROUP BY pid);






