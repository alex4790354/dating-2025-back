CREATE TABLE main.web_user (
    id  SERIAL,
    email CHARACTER VARYING(255) NOT NULL,
    name CHARACTER VARYING(255) NOT NULL,
    password CHARACTER VARYING(255) NOT NULL,
    cur_role CHARACTER VARYING(100) NOT NULL DEFAULT 'WEB',
    CONSTRAINT web_user_pk PRIMARY KEY (id),
    CONSTRAINT web_user_email_uniqe UNIQUE (email)
);
INSERT INTO main.web_user(email, name, password, cur_role) VALUES ('1@gmail.com', 'User 1', '$2a$10$AocWpRcC2JddKP7JncsE8uhyPx1gAzgL4WlYwNEv9nfHhGY9z9ski', 'WEB');
INSERT INTO main.web_user(email, name, password, cur_role) VALUES ('2@gmail.com', 'User 2', '$2a$10$AocWpRcC2JddKP7JncsE8uhyPx1gAzgL4WlYwNEv9nfHhGY9z9ski', 'WEB');
INSERT INTO main.web_user(email, name, password, cur_role) VALUES ('3@gmail.com', 'User 3', '$2a$10$AocWpRcC2JddKP7JncsE8uhyPx1gAzgL4WlYwNEv9nfHhGY9z9ski', 'WEB');
INSERT INTO main.web_user(email, name, password, cur_role) VALUES ('4@gmail.com', 'User 4', '$2a$10$AocWpRcC2JddKP7JncsE8uhyPx1gAzgL4WlYwNEv9nfHhGY9z9ski', 'WEB');


CREATE TABLE main.web_role (
    id SERIAL,
    name CHARACTER VARYING(100) default NULL,
    CONSTRAINT web_role_pk PRIMARY KEY (id)
);
INSERT INTO main.web_role (name) VALUES ('WEB');
INSERT INTO main.web_role (name) VALUES ('FREE');
INSERT INTO main.web_role (name) VALUES ('SILVER');
INSERT INTO main.web_role (name) VALUES ('GOLD');
INSERT INTO main.web_role (name) VALUES ('ADMIN');
INSERT INTO main.web_role (name) VALUES ('SITE_OWNER');
INSERT INTO main.web_role (name) VALUES ('SUPER_USER');


CREATE TABLE main.web_user_role (
    web_user_id int NOT NULL,
    web_role_id int NOT NULL,
    CONSTRAINT web_user_role_fk1 FOREIGN KEY (web_user_id) REFERENCES main.web_user (id),
    CONSTRAINT web_user_role_fk2 FOREIGN KEY (web_role_id) REFERENCES main.web_role (id)
);
INSERT INTO main.web_user_role (web_user_id, web_role_id) VALUES(1, 7);
INSERT INTO main.web_user_role (web_user_id, web_role_id) VALUES(4, 2);

