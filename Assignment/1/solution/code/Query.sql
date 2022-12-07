# --------- 1 ---------
SELECT *
FROM product
WHERE p_id NOT IN (
	SELECT p_id
	FROM rating
    );
    
# --------- 2 ---------
SELECT u_name
FROM user_
WHERE u_id IN (
	SELECT u_id
	FROM order_
	WHERE p_id IN (
		SELECT p_id
		FROM product
		WHERE c_id = (
			SELECT c_id
			FROM category
			WHERE c_name = 'Sport'
			LIMIT 1
			)
		)
	GROUP BY u_id
	HAVING COUNT(*) >3
);

# --------- 3 ---------
SELECT *
FROM product
WHERE p_id IN 
(
	SELECT p_id
	FROM rating
	GROUP BY p_id
	HAVING AVG(rate)>4
);


# --------- 4 ---------
SELECT *
FROM product
WHERE p_id IN
(
	SELECT order_.p_id
	FROM product, order_
	WHERE product.p_id = order_.p_id
	GROUP BY order_.p_id
	HAVING SUM(price*quantity) > 100
);

# --------- 5 ---------
SELECT COUNT(*)
FROM 
(
	SELECT u_id
	FROM product, order_
	WHERE product.p_id = order_.p_id
	GROUP BY t_stamp, u_id
	HAVING t_stamp = '2021-11-25' AND SUM(price*quantity)>100
) AS spender;

# --------- 6 ---------
SELECT u_name, spender.total
FROM user_ , 
(
	SELECT u_id, SUM(price*quantity) AS total
	FROM product, order_
	WHERE product.p_id = order_.p_id AND u_id=5
	GROUP BY u_id
) AS spender
WHERE user_.u_id = spender.u_id

# --------- 7 ---------
SELECT *
FROM product
WHERE p_id = 
(
	SELECT p_id
	FROM order_
	GROUP BY p_id
	ORDER BY SUM(quantity) DESC
	LIMIT 1
);

# --------- 8 ---------
SELECT c_name
FROM category
WHERE c_id = 
(
	SELECT c_id
	FROM product,
	(
		SELECT p_id, SUM(quantity) AS qty
		FROM order_
		GROUP BY p_id
	) AS selling
	WHERE product.p_id = selling.p_id
	GROUP BY c_id
	ORDER BY SUM(selling.qty) DESC
	LIMIT 1
);


# --------- 9 ---------
SELECT u_id
FROM rating
WHERE u_id NOT IN 
(
	SELECT u_id
	FROM rating
	GROUP BY u_id 
	ORDER BY COUNT(*) DESC
	LIMIT 1
)
GROUP BY u_id 
ORDER BY COUNT(*) DESC
LIMIT 1

# --------- 10 ---------
SELECT u_name
FROM user_
WHERE u_id = 
(
	SELECT mn.u_id
	FROM
	(
		SELECT u_id, MAX(t_stamp) as max_date
		FROM rating
		GROUP BY u_id
	) AS mx,
	(
		SELECT u_id, MIN(t_stamp) as min_date
		FROM rating
		GROUP BY u_id
	) AS mn
	WHERE mn.u_id = mx.u_id
	GROUP BY mn.u_id
	ORDER BY MAX(mx.max_date - mn.min_date) DESC
	LIMIT 1
);

