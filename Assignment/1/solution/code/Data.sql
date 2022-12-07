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



