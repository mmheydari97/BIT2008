CREATE TABLE user_(
	u_id SERIAL,
	u_name VARCHAR(20),
	u_address VARCHAR(50),
	u_phone NUMERIC(10,0),
	PRIMARY KEY (u_id)
);

CREATE TABLE category(
	c_id SERIAL,
	c_name VARCHAR(20),
	PRIMARY KEY (c_id)
);

CREATE TABLE product(
	p_id SERIAL,
	p_name VARCHAR(20),
	c_id INT,
	price NUMERIC(10),
	
	FOREIGN KEY (c_id) REFERENCES category(c_id),
    PRIMARY KEY (p_id)
);
    
CREATE TABLE order_(
	o_id SERIAL,
    u_id INT,
    p_id INT,
    quantity NUMERIC(5,0) DEFAULT 1,
    shipping BOOLEAN DEFAULT False,
    t_stamp DATE,
    
	FOREIGN KEY (u_id) REFERENCES user_(u_id),
    FOREIGN KEY (p_id) REFERENCES product(p_id),
    PRIMARY KEY (o_id)
	);

CREATE TABLE rating(
	u_id INT,
    p_id INT,
    rate NUMERIC(1),
    t_stamp DATE,

	FOREIGN KEY (u_id) REFERENCES user_(u_id),
    FOREIGN KEY (p_id) REFERENCES product(p_id),
    PRIMARY KEY (u_id, p_id)
	);


INSERT INTO user_ (u_name, u_address, u_phone) VALUES ('Alex','main',6131231233);
INSERT INTO user_ (u_name, u_address, u_phone) VALUES ('Martin','main',6132456789);
INSERT INTO user_ (u_name, u_address, u_phone) VALUES ('Sara','main',3432356789);
INSERT INTO user_ (u_name, u_address, u_phone) VALUES ('Joe','bank',3431122334);
INSERT INTO user_ (u_name, u_address, u_phone) VALUES ('Kate','bank',6132255447);
INSERT INTO user_ (u_name, u_address, u_phone) VALUES ('Lily','rideau',3431111111);


INSERT INTO category (c_id, c_name) VALUES (1,'Sport');
INSERT INTO category (c_id, c_name) VALUES (2,'Book');
INSERT INTO category (c_id, c_name) VALUES (3,'Electronic');


INSERT INTO product (p_name,c_id, price) VALUES ('nike shoes', 1, 10);
INSERT INTO product (p_name,c_id, price) VALUES ('puma shoes', 1, 12);
INSERT INTO product (p_name,c_id, price) VALUES ('the little prince', 2, 20);
INSERT INTO product (p_name,c_id, price) VALUES ('the idiot', 2, 25);
INSERT INTO product (p_name,c_id, price) VALUES ('msi gaming', 3, 100);
INSERT INTO product (p_name,c_id, price) VALUES ('dell xps', 3, 200);
INSERT INTO product (p_name,c_id, price) VALUES ('apple macbook', 3, 250);
INSERT INTO product (p_name,c_id, price) VALUES ('barfix', 1, 40);
INSERT INTO product (p_name,c_id, price) VALUES ('rope', 1, 15);


INSERT INTO order_ (u_id, p_id, quantity, shipping, t_stamp) VALUES (1,5,2,FALSE,'2022-01-06');
INSERT INTO order_ (u_id, p_id, quantity, shipping, t_stamp) VALUES (1,6,1,TRUE,'2021-12-06');
INSERT INTO order_ (u_id, p_id, quantity, shipping, t_stamp) VALUES (2,2,100,TRUE,'2021-12-05');
INSERT INTO order_ (u_id, p_id, quantity, shipping, t_stamp) VALUES (2,4,30,TRUE,'2021-12-16');
INSERT INTO order_ (u_id, p_id, quantity, shipping, t_stamp) VALUES (6,1,2,FALSE,'2021-11-25');
INSERT INTO order_ (u_id, p_id, quantity, shipping, t_stamp) VALUES (6,8,2,FALSE,'2021-11-25');
INSERT INTO order_ (u_id, p_id, quantity, shipping, t_stamp) VALUES (6,9,1,FALSE,'2021-11-25');
INSERT INTO order_ (u_id, p_id, quantity, shipping, t_stamp) VALUES (6,2,2,FALSE,'2021-11-25');
INSERT INTO order_ (u_id, p_id, quantity, shipping, t_stamp) VALUES (5,1,1,FALSE,'2021-11-25');
INSERT INTO order_ (u_id, p_id, quantity, shipping, t_stamp) VALUES (5,3,1,TRUE,'2021-11-25');
INSERT INTO order_ (u_id, p_id, quantity, shipping, t_stamp) VALUES (5,4,2,TRUE,'2021-11-25');


INSERT INTO rating (u_id, p_id, rate , t_stamp) VALUES (1,1,5,'2022-06-06');
INSERT INTO rating (u_id, p_id, rate , t_stamp) VALUES (1,2,3,'2022-06-06');
INSERT INTO rating (u_id, p_id, rate , t_stamp) VALUES (1,3,3,'2022-05-06');
INSERT INTO rating (u_id, p_id, rate , t_stamp) VALUES (2,3,4,'2022-06-06');
INSERT INTO rating (u_id, p_id, rate , t_stamp) VALUES (2,4,5,'2022-06-05');
INSERT INTO rating (u_id, p_id, rate , t_stamp) VALUES (3,1,4,'2022-05-06');


-------------------------- 14 -------------------------- 
CREATE OR REPLACE FUNCTION top_ratings(thresh INTEGER)
RETURNS INTEGER
AS
$$
DECLARE
	cnt_products INTEGER;
BEGIN
	WITH avg_rating AS (
	SELECT p_id, AVG(rate) AS avg_rate
	FROM rating
	GROUP BY p_id
	)
	SELECT COUNT(*) INTO cnt_products
	FROM avg_rating
	WHERE avg_rate>thresh;
	RETURN cnt_products;
END;
$$ LANGUAGE plpgsql;

-------------------------- 15 -------------------------- 
CREATE OR REPLACE FUNCTION upd_p_name(p_id INTEGER, new_p_name VARCHAR(20))
RETURNS VOID
AS
$$
BEGIN
	UPDATE product
	SET p_name = new_p_name
	WHERE product.p_id = upd_p_name.p_id;
END;
$$ LANGUAGE plpgsql;

-------------------------- 16 -------------------------- 
CREATE OR REPLACE FUNCTION order_detail(order_id INTEGER)
RETURNS TABLE (o_id INT,
			   u_id INT,
			   p_id INT,
			   quantity NUMERIC(5,0),
			   shipping BOOLEAN,
			   t_stamp DATE) AS
$$
BEGIN
	RETURN QUERY
	SELECT *
	FROM order_
	WHERE order_.o_id = order_detail.order_id;
END;
$$ LANGUAGE plpgsql;

-------------------------- 17 -------------------------- 
CREATE OR REPLACE FUNCTION set_date()
RETURNS TRIGGER AS
$$
BEGIN
	NEW.t_stamp = CURRENT_DATE;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER order_date_trigger
BEFORE INSERT
ON order_
FOR EACH ROW
EXECUTE PROCEDURE set_date();

INSERT INTO order_(u_id,p_id,quantity,shipping,t_stamp)
VALUES (1,1,1,False,NULL);

-------------------------- 18 -------------------------- 
CREATE OR REPLACE FUNCTION set_shipping()
RETURNS TRIGGER AS
$$
BEGIN
	IF OLD.shipping=TRUE AND NEW.shipping=FALSE THEN
	NEW.shipping = TRUE;
	END IF;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER order_shipping_trigger
BEFORE UPDATE
ON order_
FOR EACH ROW
EXECUTE PROCEDURE set_shipping();

UPDATE order_
SET shipping=False
WHERE o_id=13;

SELECT *
FROM order_;