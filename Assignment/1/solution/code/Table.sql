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


    