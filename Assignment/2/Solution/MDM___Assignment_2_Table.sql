CREATE TABLE branch(
	b_id SERIAL,
    b_name VARCHAR(100) NOT NULL,
    mgr_name VARCHAR(100),
    asst_name VARCHAR(100),
    life_available BOOLEAN,
    home_available BOOLEAN,
	car_available BOOLEAN,
    PRIMARY KEY(b_id)
);

CREATE TABLE employee(
	e_id SERIAL,
    e_name VARCHAR(100) NOT NULL,
    address VARCHAR(100),
    phone_number NUMERIC(10,0),
    pass CHAR(4),
    b_id INTEGER,
    FOREIGN KEY (b_id) REFERENCES branch(b_id),
    PRIMARY KEY(e_id)
);


CREATE TABLE box(
	e_id SERIAL,
    credit NUMERIC(12, 2),
    FOREIGN KEY (e_id) REFERENCES employee(e_id),
    PRIMARY KEY(e_id)
);


CREATE TABLE client(
	c_id SERIAL,
    c_name VARCHAR(100) NOT NULL,
    address VARCHAR(100),
    age INTEGER,
    phone NUMERIC(10,0),
    pass CHAR(4),
	PRIMARY KEY(c_id)
);

CREATE TABLE sys(
	c_id INTEGER,
    c_text TEXT,
    FOREIGN KEY (c_id) REFERENCES client(c_id)
);

CREATE TABLE insurance(
	i_id SERIAL,
    price NUMERIC(12, 2),
    start_date TIMESTAMP,
	end_date TIMESTAMP,
    i_type INTEGER, -- can have other types too
    b_id INTEGER,
    c_id INTEGER,
    FOREIGN KEY (b_id) REFERENCES branch(b_id),
    FOREIGN KEY (c_id) REFERENCES client(c_id),
    PRIMARY KEY(i_id)
);

create table car_insurance(
	i_id INTEGER,
    license CHAR(7),
    model VARCHAR(20),
    year_ INTEGER,
    color VARCHAR(10),
    FOREIGN KEY (i_id) REFERENCES insurance(i_id),
    PRIMARY KEY(i_id)
);

CREATE TABLE life_insurance(
	i_id INTEGER,
    _name VARCHAR(100),
    birth_year INTEGER,
    sin NUMERIC(9,0) NOT NULL,
    FOREIGN KEY (i_id) REFERENCES insurance(i_id),
    PRIMARY KEY(i_id)
);

CREATE TABLE home_insurance(
	i_id INTEGER,
    address VARCHAR(100),
    surface FLOAT,
    year_ INTEGER,
    FOREIGN KEY (i_id) REFERENCES insurance(i_id),
    PRIMARY KEY(i_id)
);