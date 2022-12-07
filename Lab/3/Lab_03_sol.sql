------------- a -------------
select current_database();

------------- b -------------
CREATE TABLE "sailor"
(
	s_id SERIAL,
	s_name VARCHAR(30),
	age INTEGER,
	rating INTEGER,
	PRIMARY KEY (s_id)
);

CREATE TABLE "boat"
(
	b_id SERIAL,
	b_name VARCHAR(30),
	color VARCHAR(30),
	PRIMARY KEY (b_id)
);

CREATE TABLE "reserve"
(
	s_id INTEGER,
	b_id INTEGER,
	r_date DATE,
	PRIMARY KEY (s_id, b_id, r_date),
	FOREIGN KEY (b_id) REFERENCES "boat",
	FOREIGN KEY (s_id) REFERENCES "sailor"
);

------------- c -------------
INSERT INTO sailor(s_name, age, rating) VALUES ('James', 45, 10);
INSERT INTO sailor(s_name, age, rating) VALUES('Mary', 36, 5);
INSERT INTO sailor(s_name, age, rating) VALUES('Robert', 50, 9);
INSERT INTO sailor(s_name, age, rating) VALUES('Patricia', 34, 8);
INSERT INTO sailor(s_name, age, rating) VALUES('John', 24, 2);
INSERT INTO sailor(s_name, age, rating) VALUES('Jennifer', 20, 2);
INSERT INTO sailor(s_name, age, rating) VALUES('Michael', 20, 10);
INSERT INTO sailor(s_name, age, rating) VALUES('Linda', 35, 3);
INSERT INTO sailor(s_name, age, rating) VALUES('David', 58, 10);
INSERT INTO sailor(s_name, age, rating) VALUES('Elizabeth', 55, 5);

INSERT INTO boat(b_name, color) VALUES('Serendipity', 'Blue');
INSERT INTO boat(b_name, color) VALUES('Imagination', 'Red');
INSERT INTO boat(b_name, color) VALUES('Liberty', 'Blue');
INSERT INTO boat(b_name, color) VALUES('Wanderlust', 'Green');
INSERT INTO boat(b_name, color) VALUES('Gale', 'Blue');
INSERT INTO boat(b_name, color) VALUES('Zephyr', 'Green');

------------- d -------------
SELECT * FROM sailor;
SELECT * FROM boat;

------------- e -------------
INSERT INTO reserve VALUES(1, 1, '2011-02-12');
INSERT INTO reserve VALUES(1, 1, '2011-02-24');
INSERT INTO reserve VALUES(1, 2, '2011-02-25');
INSERT INTO reserve VALUES(1, 3, '2011-02-26');
INSERT INTO reserve VALUES(1, 4, '2011-02-24');
INSERT INTO reserve VALUES(1, 5, '2011-02-26');
INSERT INTO reserve VALUES(1, 6, '2011-02-28');
INSERT INTO reserve VALUES(6, 1, '2011-02-12');
INSERT INTO reserve VALUES(6, 1, '2011-02-24');
INSERT INTO reserve VALUES(6, 2, '2011-02-25');
INSERT INTO reserve VALUES(6, 3, '2011-02-26');
INSERT INTO reserve VALUES(6, 4, '2011-02-24');
INSERT INTO reserve VALUES(6, 5, '2011-02-26');
INSERT INTO reserve VALUES(6, 6, '2011-02-28');
INSERT INTO reserve VALUES(2, 1, '2011-02-12');
INSERT INTO reserve VALUES(2, 1, '2011-02-24');
INSERT INTO reserve VALUES(2, 2, '2011-02-25');
INSERT INTO reserve VALUES(2, 3, '2011-02-26');
INSERT INTO reserve VALUES(3, 4, '2011-02-24');
INSERT INTO reserve VALUES(3, 5, '2011-02-26');
INSERT INTO reserve VALUES(3, 6, '2011-02-28');
INSERT INTO reserve VALUES(4, 1, '2011-02-12');
INSERT INTO reserve VALUES(5, 1, '2011-02-24');
INSERT INTO reserve VALUES(4, 2, '2011-02-25');
INSERT INTO reserve VALUES(5, 3, '2011-02-26');
INSERT INTO reserve VALUES(4, 4, '2011-02-24');
INSERT INTO reserve VALUES(5, 5, '2011-02-26');
INSERT INTO reserve VALUES(4, 6, '2011-02-28');
INSERT INTO reserve VALUES(7, 1, '2011-02-12');
INSERT INTO reserve VALUES(7, 1, '2011-02-24');
INSERT INTO reserve VALUES(8, 2, '2011-02-25');
INSERT INTO reserve VALUES(8, 3, '2011-02-26');
INSERT INTO reserve VALUES(8, 4, '2011-02-24');
INSERT INTO reserve VALUES(7, 5, '2011-02-26');
INSERT INTO reserve VALUES(8, 6, '2011-02-28');

------------- f -------------
SELECT s_id
FROM reserve
WHERE b_id=3;

------------- g -------------
SELECT sname 
FROM sailor
WHERE s_id IN
	(SELECT s_id
	FROM reserve
	WHERE b_id=3)


------------- h -------------
SELECT s_name
FROM sailor
WHERE s_id NOT IN
	(SELECT s_id
	FROM reserve
	);


------------- i -------------
SELECT DISTINCT s_id  
	FROM reserve
	WHERE b_id IN
		(
			SELECT b_id
			FROM boat
			WHERE color='Red' OR color='Green'
		);

------------- j -------------
SELECT s_name
FROM sailor
WHERE s_id IN
	(
	(SELECT s_id
	FROM reserve
	WHERE b_id IN
		(
		SELECT b_id
		FROM boat
		WHERE color='Red'
		)
	)
	EXCEPT
	(SELECT s_id
	FROM reserve
	WHERE b_id IN
		(
		SELECT b_id
		FROM boat
		WHERE color='Green'
		)
	)
);





