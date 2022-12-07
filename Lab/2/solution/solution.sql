DROP DATABASE IF EXISTS "BIT2008";

CREATE DATABASE "BIT2008"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

SELECT current_database()

# ----------- 1 -----------
CREATE TABLE dept(
			deptno	INT,
			dname	VARCHAR(20),
			PRIMARY KEY (deptno));

CREATE TABLE emp(
			eid		SERIAL,
			ename	VARCHAR(20),
			salary	NUMERIC(8,2),
			deptno	INT,
			PRIMARY KEY (eid),
			FOREIGN KEY	(deptno) REFERENCES dept(deptno));

# ----------- 2 -----------
INSERT INTO dept(deptno, dname) VALUES (1,'inventory');
INSERT INTO dept(deptno, dname) VALUES (2,'sales');
INSERT INTO dept(deptno, dname) VALUES (3,'mgmt');
INSERT INTO dept(deptno, dname) VALUES (4,'finance');
INSERT INTO dept(deptno, dname) VALUES (5,'support');


INSERT INTO emp (ename, salary, deptno) VALUES ('a',100,1);
INSERT INTO emp (ename, salary, deptno) VALUES ('b',1000,1);
INSERT INTO emp (ename, salary, deptno) VALUES ('c',200,1);
INSERT INTO emp (ename, salary, deptno) VALUES ('d',200,1);
INSERT INTO emp (ename, salary, deptno) VALUES ('e',1000,1);
INSERT INTO emp (ename, salary, deptno) VALUES ('f',150,1);
INSERT INTO emp (ename, salary, deptno) VALUES ('g',100,1);
INSERT INTO emp (ename, salary, deptno) VALUES ('h',100,1);
INSERT INTO emp (ename, salary, deptno) VALUES ('i',100,1);
INSERT INTO emp (ename, salary, deptno) VALUES ('j',100,1);
INSERT INTO emp (ename, salary, deptno) VALUES ('k',120,2);
INSERT INTO emp (ename, salary, deptno) VALUES ('l',150,2);
INSERT INTO emp (ename, salary, deptno) VALUES ('m',150,2);
INSERT INTO emp (ename, salary, deptno) VALUES ('n',150,2);
INSERT INTO emp (ename, salary, deptno) VALUES ('o',200,2);
INSERT INTO emp (ename, salary, deptno) VALUES ('p',120,2);
INSERT INTO emp (ename, salary, deptno) VALUES ('manager',10000,3);

 
# ----------- 3 -----------
SELECT *
FROM emp;

# ----------- 4 -----------
SELECT ename 
FROM emp
WHERE salary > 100
LIMIT 5;

# ----------- 5 -----------
CREATE TABLE prj(
			pid SERIAL,
         pname VARCHAR(20),
			PRIMARY KEY (pid));

CREATE TABLE prjmember(
						pid INT,
                     eid INT,
                     FOREIGN KEY (pid) REFERENCES prj(pid),
                     FOREIGN KEY (eid) REFERENCES emp(eid));

# ----------- 6 -----------
INSERT INTO prj(pname) VALUES('A');
INSERT INTO prj(pname) VALUES('B');
INSERT INTO prj(pname) VALUES('C');
INSERT INTO prj(pname) VALUES('D');

INSERT INTO prjmember(pid, eid) VALUES (1,17);
INSERT INTO prjmember(pid, eid) VALUES (1,15);
INSERT INTO prjmember(pid, eid) VALUES (1,2);

INSERT INTO prjmember(pid, eid) VALUES (2,1);
INSERT INTO prjmember(pid, eid) VALUES (2,2);
INSERT INTO prjmember(pid, eid) VALUES (2,3);
INSERT INTO prjmember(pid, eid) VALUES (2,4);

INSERT INTO prjmember(pid, eid) VALUES (3,1);
INSERT INTO prjmember(pid, eid) VALUES (3,6);

INSERT INTO prjmember(pid, eid) VALUES (4,6);
INSERT INTO prjmember(pid, eid) VALUES (4,7);
INSERT INTO prjmember(pid, eid) VALUES (4,8);
INSERT INTO prjmember(pid, eid) VALUES (4,9);
INSERT INTO prjmember(pid, eid) VALUES (4,17);

# ----------- 7 -----------
UPDATE prj
SET pname = 'E'
WHERE pname = 'D';

# ----------- 8 -----------
SELECT ename, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

# ----------- 9 -----------
SELECT ename
FROM emp
where deptno in (
			SELECT deptno
			FROM dept
			WHERE dname='inventory' OR dname='sales');

# ----------- 10 -----------
SELECT dname
FROM dept
WHERE deptno NOT IN (
					SELECT deptno
                 FROM emp)

# ----------- 11 -----------
SELECT ename, salary, deptno
FROM emp WHERE (salary,deptno) IN
(SELECT MAX(salary) AS salary, deptno
FROM emp
GROUP BY deptno);

As an exercise print ename, salary and dname this time 

# ----------- 12 -----------
SELECT pname
FROM prj
WHERE pid IN (
			SELECT pid 
			FROM prjmember
			GROUP BY pid
			HAVING COUNT(eid) < 4);

# ----------- 13 -----------
SELECT SUM(salary)
FROM emp
WHERE eiD IN(
		SELECT eid
		FROM prjmember
		WHERE pid IN(
			SELECT pid
			FROM prj
			WHERE pname = 'B')
		);

# ----------- 14 -----------
WITH T AS (
	SELECT pid, AVG(Salary) AS average
	FROM prjmember, emp
	WHERE prjmember.eid = emp.eid
	GROUP BY pid
)
SELECT pname , average
FROM prj, T
WHERE prj.pid = T.pid;