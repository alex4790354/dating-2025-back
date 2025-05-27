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
ALTER TABLE main.net_country_name ADD CONSTRAINT net_country_name_fk_01 FOREIGN KEY (id)  REFERENCES main.net_country (id);


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


CREATE TABLE main.all_users
(
    id         SERIAL,
    first_name character varying(50)  NOT NULL,
    last_name  character varying(50)  NOT NULL,
    email      character varying(50)  NOT NULL,
    password   character varying(200) NOT NULL,
    CONSTRAINT customer_pk PRIMARY KEY (id),
    CONSTRAINT customer_email_uniqe UNIQUE (email)
);
INSERT INTO main.all_users (password, first_name, last_name, email) VALUES ('password', 'David', 'Adams', 'admin@job4j.com');
INSERT INTO main.all_users (password, first_name, last_name, email) VALUES ('password', 'John', 'Doe', 'john@job4j.com');
INSERT INTO main.all_users (password, first_name, last_name, email) VALUES ('password', 'Ajay', 'Rao', 'ajay@job4j.com');
INSERT INTO main.all_users (password, first_name, last_name, email) VALUES ('password', 'Mary', 'Public', 'mary@job4j.com');


drop table main.main_cv;
drop table main.marital_status;
drop table main.genders;

CREATE TABLE main.genders
(
    language    CHARACTER VARYING(3)  NOT NULL,
    gender      CHARACTER VARYING(3)  NOT NULL,
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
    gender          CHARACTER(3)          NOT NULL,
    status_name     CHARACTER VARYING(50) NOT NULL,
    CONSTRAINT marital_status_pk PRIMARY KEY (marital_status_id, language, gender)
);
ALTER TABLE main.marital_status ADD CONSTRAINT marital_status_fk_01 FOREIGN KEY (language, gender)  REFERENCES main.genders (language, gender);

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

DROP TABLE main.main_cv;
CREATE TABLE IF NOT EXISTS main.main_cv
(
    user_id SERIAL,
    language                CHARACTER VARYING(3)    NOT NULL,
    gender                  CHARACTER(3)            NOT NULL,
    city_id                 int NOT NULL DEFAULT 23541,
    date_of_birth           date                    NOT NULL,
    ad_nickname             CHARACTER VARYING(100)  NOT NULL,
    cv_text                 CHARACTER VARYING(2500) NOT NULL,
    marital_status_id       INTEGER                 NOT NULL DEFAULT 0,
    latitude                NUMERIC(9,6)            NOT NULL DEFAULT 0,
    longitude               NUMERIC(9,6)            NOT NULL DEFAULT 0,
    CONSTRAINT ad_pk PRIMARY KEY (user_id),
    CONSTRAINT ad_fk_01 FOREIGN KEY (marital_status_id, language, gender)  REFERENCES main.marital_status (marital_status_id, language, gender),
    CONSTRAINT ad_fk_02 FOREIGN KEY (language, gender)  REFERENCES main.genders (language, gender)
);

INSERT INTO main.main_cv (language, gender, date_of_birth, ad_nickname, cv_text, marital_status_id)
VALUES
('ru', 'm', '1971-01-11', 'Вася', 'Классный мужчина ищет шикарную даму', '2'),
('ru', 'w', '1972-02-12', 'Васелиса', 'Шикарная дама ищет оленя', '3'),
('en', 'm', '1973-03-13', 'Jhon', 'Cool man looking for cool girl', '4'),
('en', 'w', '1974-04-14', 'Vanessa', 'Pretty girl looking for good man', '5');


INSERT INTO main.main_cv (language, gender, date_of_birth, ad_nickname, cv_text, marital_status_id)
VALUES
('ru', 'm', '1971-01-11', 'Вася', 'Классный мужчина ищет шикарную даму', '1'),
('ru', 'm', '1972-02-12', 'Константин', 'Шикарный парень ищет девицу', '2'),
('ru', 'm', '1980-03-15', 'Игорь', 'Успешный бизнесмен в поисках спутницы жизни', '3'),
('ru', 'm', '1985-07-22', 'Алексей', 'Романтик ищет свою вторую половинку', '4'),
('ru', 'm', '1978-11-30', 'Дмитрий', 'Спортсмен желает познакомиться с активной девушкой', '5'),
('ru', 'm', '1982-09-05', 'Сергей', 'Творческая личность в поиске музы', '0'),
('ru', 'm', '1975-04-18', 'Андрей', 'Интеллектуал ищет умную и красивую спутницу', '1'),
('ru', 'm', '1988-12-03', 'Михаил', 'Путешественник ищет попутчицу по жизни', '2'),
('ru', 'm', '1976-06-27', 'Николай', 'Надежный мужчина ищет серьезные отношения', '3'),
('ru', 'm', '1983-08-14', 'Павел', 'Добрый и заботливый парень ищет любящую девушку', '4'),
('ru', 'm', '1979-10-09', 'Виктор', 'Целеустремленный мужчина ищет амбициозную партнершу', '5'),
('ru', 'm', '1986-05-25', 'Евгений', 'Веселый оптимист ищет жизнерадостную девушку', '1'),
('ru', 'm', '1974-02-08', 'Олег', 'Состоявшийся мужчина ищет женщину своей мечты', '2'),
('ru', 'm', '1981-11-17', 'Артем', 'Креативный дизайнер в поиске вдохновения и любви', '3'),
('ru', 'm', '1977-09-23', 'Владимир', 'Уверенный в себе мужчина ищет надежную спутницу', '4'),
('ru', 'm', '1984-03-31', 'Денис', 'Любитель приключений ищет партнершу для путешествий', '5'),
('ru', 'm', '1973-07-07', 'Антон', 'Серьезный мужчина ищет женщину для создания семьи', '0'),
('ru', 'm', '1987-01-19', 'Роман', 'Молодой предприниматель ищет умную и красивую девушку', '0'),
('ru', 'm', '1976-12-11', 'Максим', 'Душа компании ищет веселую и общительную спутницу', '1'),
('ru', 'm', '1982-04-29', 'Илья', 'Заботливый мужчина ищет женщину для серьезных отношений', '2'),
('ru', 'm', '1978-08-16', 'Григорий', 'Интеллигентный мужчина ищет утонченную даму', '3'),
('ru', 'm', '1985-10-02', 'Федор', 'Спокойный и уравновешенный парень ищет свою половинку', '5'),
('ru', 'm', '1975-06-13', 'Юрий', 'Надежный мужчина ищет верную спутницу жизни', '4'),
('ru', 'm', '1989-02-28', 'Борис', 'Амбициозный молодой человек ищет целеустремленную девушку', '1'),
('ru', 'm', '1980-12-20', 'Леонид', 'Творческая натура в поиске родственной души', '2'),

('ru', 'w', '1985-03-20', 'Елена', 'Очаровательная блондинка ищет надежного мужчину', '1'),
('ru', 'w', '1979-07-15', 'Ольга', 'Успешная бизнес-леди в поиске достойного партнера', '2'),
('ru', 'w', '1990-11-03', 'Анна', 'Молодая и энергичная девушка ищет веселого спутника', '3'),
('ru', 'w', '1982-05-28', 'Мария', 'Заботливая и нежная женщина мечтает о крепкой семье', '4'),
('ru', 'w', '1988-09-12', 'Екатерина', 'Творческая натура ищет родственную душу', '5'),
('ru', 'w', '1976-01-07', 'Наталья', 'Опытная и мудрая женщина ищет серьезные отношения', '0'),
('ru', 'w', '1993-06-19', 'Дарья', 'Спортивная и активная девушка ищет партнера для жизни и приключений', '1'),
('ru', 'w', '1980-12-25', 'Ирина', 'Интеллигентная дама ищет образованного мужчину', '2'),
('ru', 'w', '1987-04-30', 'Светлана', 'Оптимистка с чувством юмора ищет позитивного спутника', '3'),
('ru', 'w', '1983-08-05', 'Татьяна', 'Домашняя и хозяйственная женщина мечтает о любящем муже', '4'),
('ru', 'w', '1991-02-14', 'Юлия', 'Романтичная натура в поиске искренней любви', '5'),
('ru', 'w', '1978-10-09', 'Алла', 'Зрелая и опытная женщина ищет достойного мужчину', '1'),
('ru', 'w', '1986-07-22', 'Марина', 'Целеустремленная карьеристка ищет успешного партнера', '2'),
('ru', 'w', '1992-12-01', 'Кристина', 'Веселая и общительная девушка ищет друга и любовника', '3'),
('ru', 'w', '1981-03-17', 'Евгения', 'Интеллектуалка ищет мужчину для глубоких отношений', '4'),
('ru', 'w', '1989-11-11', 'Алина', 'Страстная и темпераментная девушка ищет сильного мужчину', '5'),
('ru', 'w', '1977-05-05', 'Вера', 'Мудрая и терпеливая женщина ищет спутника жизни', '0'),
('ru', 'w', '1994-09-28', 'Ксения', 'Молодая мама ищет заботливого отца для своего ребенка', '1'),
('ru', 'w', '1984-06-13', 'Людмила', 'Добрая и отзывчивая женщина мечтает о крепкой семье', '2'),
('ru', 'w', '1975-02-23', 'Галина', 'Состоявшаяся женщина ищет мужчину для серьезных отношений', '3'),
('ru', 'w', '1990-08-08', 'Полина', 'Творческая и артистичная натура ищет вдохновение и любовь', '4'),
('ru', 'w', '1982-04-04', 'Надежда', 'Оптимистка ищет мужчину, с которым можно горы свернуть', '5'),
('ru', 'w', '1988-12-12', 'Виктория', 'Амбициозная девушка ищет мужчину с похожими целями', '0'),
('ru', 'w', '1979-10-31', 'Лариса', 'Загадочная и таинственная женщина ищет сильного партнера', '1'),
('ru', 'w', '1993-01-01', 'Анастасия', 'Молодая и наивная девушка ищет опытного наставника', '2'),

('en', 'm', '1980-05-15', 'Michael', 'Successful entrepreneur seeking a partner in life and business', '1'),
('en', 'm', '1975-09-22', 'David', 'Divorced dad looking for a new start with the right woman', '2'),
('en', 'm', '1988-03-10', 'Chris', 'Fitness enthusiast searching for an active and healthy partner', '0'),
('en', 'm', '1982-11-07', 'Robert', 'Tech geek with a big heart, looking for my player two', '1'),
('en', 'm', '1979-07-30', 'William', 'World traveler seeking a companion for life''s adventures', '4'),
('en', 'm', '1985-01-18', 'James', 'Creative artist looking for a muse and soulmate', '5'),
('en', 'm', '1977-06-25', 'John', 'Widower ready to find love again with a caring woman', '3'),
('en', 'm', '1990-12-03', 'Richard', 'Young professional seeking intelligent and ambitious partner', '1'),
('en', 'm', '1973-04-11', 'Thomas', 'Experienced man looking for a mature relationship', '2'),
('en', 'm', '1986-08-20', 'Mark', 'Outdoor enthusiast searching for a nature-loving companion', '4'),
('en', 'm', '1981-02-14', 'Charles', 'Romantic at heart, seeking my true love', '1'),
('en', 'm', '1976-10-09', 'Steven', 'Divorced but optimistic, looking for a fresh start', '2'),
('en', 'm', '1989-05-27', 'Daniel', 'Ambitious entrepreneur seeking equally driven partner', '1'),
('en', 'm', '1983-09-16', 'Paul', 'Music lover searching for harmony in life and love', '1'),
('en', 'm', '1978-12-25', 'Andrew', 'Family-oriented man looking for a lifelong commitment', '4'),
('en', 'm', '1987-03-08', 'Joseph', 'Funny guy seeking a woman who appreciates good humor', '4'),
('en', 'm', '1974-07-19', 'George', 'Seasoned professional looking for meaningful connection', '2'),
('en', 'm', '1992-01-05', 'Kenneth', 'Young and ambitious, seeking a partner to conquer the world', '1'),
('en', 'm', '1984-06-30', 'Edward', 'Intellectual seeking stimulating conversations and love', '3'),
('en', 'm', '1979-11-11', 'Brian', 'Sports fanatic looking for a teammate in life', '1'),
('en', 'm', '1988-04-23', 'Ronald', 'Animal lover seeking a kind-hearted partner', '4'),
('en', 'm', '1975-08-07', 'Anthony', 'Divorced dad, ready for new chapter with the right woman', '2'),
('en', 'm', '1982-12-14', 'Kevin', 'Tech entrepreneur seeking innovation in love and life', '1'),
('en', 'm', '1977-02-28', 'Jason', 'Laid-back guy looking for a drama-free relationship', '4'),
('en', 'm', '1990-10-01', 'Matthew', 'Aspiring chef looking to cook up love with the right ingredient', '5'),

('en', 'w', '1985-07-12', 'Emily', 'Career-driven woman seeking balance with the right partner', '1'),
('en', 'w', '1979-03-25', 'Sarah', 'Single mom looking for a supportive and loving man', '2'),
('en', 'w', '1992-09-08', 'Jessica', 'Fitness instructor searching for a health-conscious soulmate', '5'),
('en', 'w', '1983-01-30', 'Ashley', 'Book lover seeking intellectual and emotional connection', '1'),
('en', 'w', '1976-11-17', 'Jennifer', 'Divorced but hopeful, ready for a new chapter in love', '2'),
('en', 'w', '1988-05-05', 'Lauren', 'Travel enthusiast looking for a partner in adventure', '4'),
('en', 'w', '1981-08-22', 'Amanda', 'Nature lover seeking a green-minded companion', '1'),
('en', 'w', '1974-04-14', 'Melissa', 'Experienced woman ready for a mature, lasting relationship', '3'),
('en', 'w', '1990-12-31', 'Rachel', 'Young professional seeking ambitious and kind-hearted man', '4'),
('en', 'w', '1986-06-19', 'Rebecca', 'Artist looking for inspiration in love and life', '1'),
('en', 'w', '1978-10-03', 'Laura', 'Divorced mom seeking a family-oriented partner', '2'),
('en', 'w', '1993-02-11', 'Nicole', 'Bubbly personality seeking someone to share laughter with', '3'),
('en', 'w', '1982-07-28', 'Emma', 'Teacher looking for a lifelong student of love', '1'),
('en', 'w', '1975-12-09', 'Michelle', 'Successful businesswoman seeking equal partnership', '4'),
('en', 'w', '1989-04-01', 'Sophia', 'Free spirit seeking open-minded companion for life''s journey', '5'),
('en', 'w', '1984-09-15', 'Olivia', 'Animal rights activist looking for a compassionate partner', '1'),
('en', 'w', '1977-05-20', 'Ava', 'Widow ready to embrace love again with the right man', '3'),
('en', 'w', '1991-11-06', 'Isabella', 'Aspiring chef looking to cook up a perfect relationship', '4'),
('en', 'w', '1980-03-18', 'Mia', 'Yoga instructor seeking balance in life and love', '1'),
('en', 'w', '1987-08-04', 'Abigail', 'Tech-savvy girl looking for a compatible connection', '3'),
('en', 'w', '1973-01-23', 'Elizabeth', 'Mature woman seeking genuine companionship', '2'),
('en', 'w', '1994-06-07', 'Charlotte', 'Recent graduate excited to start a new chapter in life and love', '2'),
('en', 'w', '1983-10-12', 'Amelia', 'Environmentalist seeking partner to save the world with', '1'),
('en', 'w', '1976-02-29', 'Evelyn', 'Divorced but optimistic, ready for a meaningful relationship', '2'),
('en', 'w', '1988-07-16', 'Harper', 'Music lover searching for harmony in romance', '1');

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
    BEFORE UPDATE ON main.main_cv
    FOR EACH ROW EXECUTE PROCEDURE tr_city_update();

