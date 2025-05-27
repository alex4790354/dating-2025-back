CREATE TABLE IF NOT EXISTS main.max_country (
    id              CHARACTER VARYING(2)    NOT NULL,
    language        CHARACTER VARYING(3)    NOT NULL,
    country_name    CHARACTER VARYING(50)   NOT NULL,
    CONSTRAINT max_country_pk PRIMARY KEY (id, language)
);


CREATE TABLE IF NOT EXISTS main.max_city (
     id             int,
     country_id     CHARACTER VARYING(2)  NOT NULL,
     region	        CHARACTER VARYING(2)  NOT NULL,
     city_name_en	CHARACTER VARYING(50) NOT NULL,
     postalCode	    CHARACTER VARYING(10) NOT NULL,
     latitude	    NUMERIC(9,6)          NOT NULL,
     longitude	    NUMERIC(9,6)          NOT NULL,
     metroCode	    int,
     areaCode       int,
     CONSTRAINT max_city_pk PRIMARY KEY (id)
);
--INSERT INTO max_city (SELECT * FROM max_city2);
--ALTER TABLE max_city ADD CONSTRAINT max_city_fk_01 FOREIGN KEY (country_id) REFERENCES max_country (id, language);


CREATE TABLE IF NOT EXISTS main.max_city_name (
    city_id         int,
    language        CHARACTER VARYING(3)    NOT NULL,
    city_name	    CHARACTER VARYING(50)   NOT NULL,
    CONSTRAINT max_city_name_pk PRIMARY KEY (city_id, language)
);
ALTER TABLE main.max_city_name ADD CONSTRAINT max_city_name_fk_01 FOREIGN KEY (city_id) REFERENCES main.max_city (id);
-- INSERT INTO max_city_name (SELECT id, 'en', city_name_en FROM max_city);
-- INSERT INTO max_city_name (SELECT id, 'ru', city_name_en FROM max_city);


CREATE TABLE IF NOT EXISTS main.max_city2 (
   id int,
   country          CHARACTER VARYING(2)  NOT NULL,
   region	        CHARACTER VARYING(2)  NOT NULL,
   city_name_en	    CHARACTER VARYING(50) NOT NULL,
   postalCode	    CHARACTER VARYING(10) NOT NULL,
   latitude	        NUMERIC(9,6)          NOT NULL,
   longitude	    NUMERIC(9,6)          NOT NULL,
   metroCode	    int,
   areaCode         int,
   CONSTRAINT max_city1_pk PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS main.net_country (
    id SERIAL,
    name_en CHARACTER VARYING(100) default NULL,
    code CHARACTER VARYING(2) default NULL,
    include CHARACTER(1),
    CONSTRAINT net_country_pk PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS main.net_country_name (
    id int NOT NULL,
    language CHARACTER VARYING(3) NOT NULL,
    name CHARACTER VARYING(100) NOT NULL,
    code CHARACTER VARYING(10) NOT NULL,
    CONSTRAINT net_country_name_pk PRIMARY KEY (id, language)
);
ALTER TABLE net_country_name ADD CONSTRAINT net_country_name_fk_01 FOREIGN KEY (id)  REFERENCES main.net_country (id);


CREATE TABLE IF NOT EXISTS main.net_city (
    id SERIAL,
    country_id   int default NULL,
    name_en      CHARACTER VARYING(100) NOT NULL,
    region       CHARACTER VARYING(10),
    latitude     NUMERIC(9,6) NOT NULL,
    longitude    NUMERIC(9,6) NOT NULL,
    CONSTRAINT net_city_pk PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS main.net_city_name (
    id int,
    language     CHARACTER VARYING(3)    NOT NULL,
    name         CHARACTER VARYING(100)  NOT NULL,
    region       CHARACTER VARYING(10),
    CONSTRAINT net_city_name_pk PRIMARY KEY (id, language)
);
ALTER TABLE main.net_city_name ADD CONSTRAINT net_city_name_fk_01 FOREIGN KEY (id)  REFERENCES main.net_city (id);
--INSERT INTO net_city_name SELECT id, 'ru', name_ru, region FROM net_city_temp;


SELECT count(*) FROM (
    select country_id, name_ru, count(*)
    FROM main.net_city_temp
    GROUP BY country_id, name_ru
    HAVING count(*) > 1
) foo;


CREATE TABLE main.customer
(
    id         SERIAL,
    first_name character varying(50)  NOT NULL,
    last_name  character varying(50)  NOT NULL,
    email      character varying(50)  NOT NULL,
    password   character varying(200) NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY (id),
    CONSTRAINT customer_email_uniqe UNIQUE (email)
);
INSERT INTO main.customer (password, first_name, last_name, email) VALUES ('password', 'David', 'Adams', 'admin@job4j.com');
INSERT INTO main.customer (password, first_name, last_name, email) VALUES ('password', 'John', 'Doe', 'john@job4j.com');
INSERT INTO main.customer (password, first_name, last_name, email) VALUES ('password', 'Ajay', 'Rao', 'ajay@job4j.com');
INSERT INTO main.customer (password, first_name, last_name, email) VALUES ('password', 'Mary', 'Public', 'mary@job4j.com');


--drop table main.ad;
--drop table main.marital_status;
--drop table main.genders;

CREATE TABLE main.genders
(
    language    CHARACTER VARYING(3)  NOT NULL,
    gender      CHARACTER VARYING(2)  NOT NULL,
    gender_name CHARACTER VARYING(50) NOT NULL,
    CONSTRAINT genders_pk PRIMARY KEY (language, gender)
);
INSERT INTO main.genders(language, gender, gender_name) VALUES ('en', 'm', 'man');
INSERT INTO main.genders(language, gender, gender_name) VALUES ('en', 'w', 'woman');
INSERT INTO main.genders(language, gender, gender_name) VALUES ('ru', 'm', 'мужчина');
INSERT INTO main.genders(language, gender, gender_name) VALUES ('ru', 'w', 'женщина');


CREATE TABLE main.marital_status
(
    marital_status_id                          int,
    language        CHARACTER VARYING(3)  NOT NULL,
    gender          CHARACTER(1)          NOT NULL,
    status_name     CHARACTER VARYING(50) NOT NULL,
    CONSTRAINT marital_status_pk PRIMARY KEY (marital_status_id, language, gender)
);
ALTER TABLE main.marital_status ADD CONSTRAINT marital_status_fk_01 FOREIGN KEY (language, gender)  REFERENCES genders (language, gender);

INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (0, 'ru', 'm', 'не выбрано');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (1, 'ru', 'm', 'не женат (и не был)');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (2, 'ru', 'm', 'разведен');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (3, 'ru', 'm', 'вдовец');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (4, 'ru', 'm', 'живем отдельно, в процессе развода');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (5, 'ru', 'm', 'женат');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (0, 'ru', 'w', 'не выбрано');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (1, 'ru', 'w', 'не замужем (и не была)');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (2, 'ru', 'w', 'разведена');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (3, 'ru', 'w', 'вдова');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (4, 'ru', 'w', 'живем отдельно, в процессе развода');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (5, 'ru', 'w', 'за мужем');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (0, 'en', 'm', 'not selected');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (1, 'en', 'm', 'single / never married');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (2, 'en', 'm', 'divorced');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (3, 'en', 'm', 'widower');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (4, 'en', 'm', 'separated');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (5, 'en', 'm', 'married');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (0, 'en', 'w', 'not selected');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (1, 'en', 'w', 'single / never married');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (2, 'en', 'w', 'divorced');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (3, 'en', 'w', 'widow');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (4, 'en', 'w', 'separated');
INSERT INTO main.marital_status (marital_status_id, language, gender, status_name) VALUES (5, 'en', 'w', 'married');


CREATE TABLE main.ad
(
    customer_id SERIAL,
    language                CHARACTER VARYING(3)    NOT NULL,
    gender                  CHARACTER(1)            NOT NULL,
    city_id                 int NOT NULL DEFAULT 23541,
    date_of_birth           date                    NOT NULL,
    ad_nickname             CHARACTER VARYING(100)  NOT NULL,
    marital_status_id       INTEGER                 NOT NULL DEFAULT 0,
    latitude                NUMERIC(9,6)            NOT NULL DEFAULT 0,
    longitude               NUMERIC(9,6)            NOT NULL DEFAULT 0,
    CONSTRAINT ad_pk PRIMARY KEY (customer_id)
);
ALTER TABLE main.ad ADD CONSTRAINT ad_fk_01 FOREIGN KEY (marital_status_id, language, gender)  REFERENCES main.marital_status (marital_status_id, language, gender);
ALTER TABLE main.ad ADD CONSTRAINT ad_fk_02 FOREIGN KEY (language, gender)  REFERENCES main.genders (language, gender);

INSERT INTO main.ad (language, gender, date_of_birth, ad_nickname, marital_status_id) VALUES ('ru', 'm', '1971-01-11', 'Вася', '2');
INSERT INTO main.ad (language, gender, date_of_birth, ad_nickname, marital_status_id) VALUES ('ru', 'w', '1972-02-12', 'Васелиса', '3');
INSERT INTO main.ad (language, gender, date_of_birth, ad_nickname, marital_status_id) VALUES ('en', 'm', '1973-03-13', 'Jhon', '4');
INSERT INTO main.ad (language, gender, date_of_birth, ad_nickname, marital_status_id) VALUES ('en', 'w', '1974-04-14', 'Vanessa', '5');



CREATE OR REPLACE FUNCTION tr_city_update()
   RETURNS TRIGGER
   LANGUAGE PLPGSQL
AS
$$
BEGIN

    IF NEW.city_id <> OLD.city_id THEN
        SELECT longitude INTO NEW.longitude FROM main.max_city WHERE id = NEW.city_id;
        SELECT latitude  INTO NEW.latitude  FROM main.max_city WHERE id = NEW.city_id;
    END IF;

    RETURN NEW;
END;
$$;


--DROP TRIGGER trigger_city_update ON ad;
CREATE TRIGGER trigger_city_update
    BEFORE UPDATE ON main.ad
    FOR EACH ROW EXECUTE PROCEDURE tr_city_update();

