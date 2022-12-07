-- ################### Fruits ################### 
----------------------- 1 -----------------------
-- CREATE TABLE basket_a (
--     a INT PRIMARY KEY,
--     fruit_a VARCHAR (100) NOT NULL,
-- 	num INTEGER DEFAULT 0
-- );

----------------------- 2 -----------------------
-- CREATE TABLE basket_b (
--     b INT PRIMARY KEY,
--     fruit_b VARCHAR (100) NOT NULL,
-- 	num INTEGER DEFAULT 0
-- );

----------------------- 3 -----------------------
-- INSERT INTO basket_a (a, fruit_a, num)
-- VALUES
--     (1, 'Apple', 10),
--     (2, 'Orange', 5),
--     (3, 'Banana', 2),
--     (4, 'Cucumber', 2);

-- INSERT INTO basket_b (b, fruit_b, num)
-- VALUES
--     (1, 'Orange', 10),
--     (2, 'Apple', 5),
--     (3, 'Watermelon', 1),
--     (4, 'Pear', 3);

----------------------- 4 -----------------------
-- SELECT  fruit_a, fruit_b, basket_a.num + basket_b.num as num
-- FROM basket_a INNER JOIN basket_b
-- ON fruit_a = fruit_b;

----------------------- 5 -----------------------
-- SELECT fruit_a, fruit_b, COALESCE(basket_a.num, 0)+COALESCE(basket_b.num, 0) as num
-- FROM basket_a FULL OUTER JOIN basket_b
-- ON fruit_a = fruit_b;

----------------------- 6 -----------------------
-- CREATE VIEW common_fruits AS
-- SELECT  fruit_a, fruit_b, basket_a.num + basket_b.num as num
-- FROM basket_a INNER JOIN basket_b
-- ON fruit_a = fruit_b;

-- SELECT *
-- FROM common_fruits;

----------------------- 7 -----------------------
-- CREATE MATERIALIZED VIEW two_baskets AS 
-- SELECT fruit_a, fruit_b, COALESCE(basket_a.num, 0)+COALESCE(basket_b.num, 0) as num
-- FROM basket_a FULL OUTER JOIN basket_b
-- ON fruit_a = fruit_b;

-- SELECT * FROM two_baskets;

----------------------- 8 -----------------------
-- DROP MATERIALIZED VIEW two_baskets;

-- CREATE MATERIALIZED VIEW two_baskets AS 
-- SELECT fruit_a, fruit_b, COALESCE(basket_a.num, 0)+COALESCE(basket_b.num, 0) as num
-- FROM basket_a FULL OUTER JOIN basket_b
-- ON fruit_a = fruit_b
-- WITH NO DATA;

-- SELECT * FROM two_baskets;

----------------------- 9 -----------------------
-- REFRESH MATERIALIZED VIEW two_baskets;
-- SELECT * FROM two_baskets;


-- ################### Cities ###################
----------------------- 1 -----------------------
-- CREATE TABLE city (
-- 	city_id INT PRIMARY KEY,
-- 	city_name VARCHAR (100) NOT NULL,
-- 	country_name VARCHAR DEFAULT 'Canada');

----------------------- 2 -----------------------
-- INSERT INTO city (city_id, city_name, country_name)
-- VALUES
-- 	(1, 'Ottawa', 'Canada'),
-- 	(2, 'Hamilton', 'Canada'),
-- 	(3, 'Toronto', 'Canada'),
-- 	(4, 'London', 'Canada');

-- SELECT * 
-- FROM city;

----------------------- 3 -----------------------
-- CREATE OR REPLACE VIEW canada_city AS
-- SELECT city_id, city_name, country_name
-- FROM city
-- WHERE country_name = 'Canada'
-- ORDER BY city_name;

----------------------- 4 -----------------------
-- INSERT INTO canada_city (city_id, city_name, country_name)
-- VALUES (5, 'Cambridge', 'England');

-- CREATE OR REPLACE VIEW canada_city AS
-- SELECT city_id, city_name, country_name
-- FROM city
-- WHERE country_name = 'Canada'
-- ORDER BY city_name
-- WITH CHECK OPTION;


-- INSERT INTO canada_city (city_id, city_name, country_name)
-- VALUES (6, 'New York', 'US');

----------------------- 5 -----------------------
-- CREATE MATERIALIZED VIEW city_backup AS
-- SELECT city_id, city_name, country_name
-- FROM city

----------------------- 6 -----------------------
-- CREATE UNIQUE INDEX city_index ON city_backup (city_id);
-- REFRESH MATERIALIZED VIEW CONCURRENTLY city_backup;

-- SELECT * FROM city_backup;

-- INSERT INTO city (city_id, city_name, country_name)
-- VALUES (6, 'Montreal', 'Canada');
-- REFRESH MATERIALIZED VIEW city_backup;
-- SELECT * FROM city_backup;