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

------------- c -------------
INSERT INTO sailor(s_name, age, rating) VALUES ('James', 45, 10);
INSERT INTO boat(b_name, color) VALUES('Serendipity', 'Blue');

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


