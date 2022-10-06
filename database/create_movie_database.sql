DROP DATABASE IF EXISTS movie_db;

-- Create database
CREATE DATABASE movie_db; 

-- Select database
USE movie_db;

-- Create table
CREATE TABLE directors_tbl(
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255),
    year_of_birth int,
    PRIMARY KEY (id)
);

-- Insert values
INSERT INTO directors_tbl VALUES(
    null,
    'James Cameron',
    1954
);

-- Create another table
CREATE TABLE movies_tbl(
    id int NOT NULL AUTO_INCREMENT,
    title varchar(255),
    release_year int,
    director_id int NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (director_id) REFERENCES directors_tbl(id)
);

-- ドライブ・マイ・カー

-- Insert values
INSERT INTO directors_tbl VALUES(
    null,
    '濱口 竜介',
    1978
);

INSERT INTO directors_tbl 
VALUES(null, 'Sofia Coppola', null),
      (null, 'Jim Jarmusch', null)
;

INSERT INTO movies_tbl VALUES(
    null,
    'Titanic',
    1997,
    (SELECT id FROM directors_tbl WHERE name like "James Cameron")
);

INSERT INTO directors_tbl 
VALUES (null, 'Christopher Nolan', 1970),
       (null, 'Patty Jenkins', 1971),
       (null, 'Chloe Zhaos', 1982)
;

INSERT INTO movies_tbl 
VALUES (null, 'Wonder Woman', 2017, (SELECT id FROM directors_tbl WHERE name like "Patty Jenkins")),
       (null, 'Avatar', 2009, (SELECT id FROM directors_tbl WHERE name like "James Cameron")),
       (null, 'Aliens', 1986, (SELECT id FROM directors_tbl WHERE name like "James Cameron")),
       (null, 'Inception', 2010, (SELECT id FROM directors_tbl WHERE name like "Christopher Nolan")),
       (null, 'Terminator', 1984, (SELECT id FROM directors_tbl WHERE name like "James Cameron")),
       (null, 'Cleopatra', 2023, (SELECT id FROM directors_tbl WHERE name like "Patty Jenkins")),
       (null, 'Eternals', 2021, (SELECT id FROM directors_tbl WHERE name like "Chloe Zhaos")),
       (null, 'The Dark Knight', 2008, (SELECT id FROM directors_tbl WHERE name like "Christopher Nolan"))
;

INSERT INTO movies_tbl
VALUES(null,'Lost In Translation', 1997, (SELECT id FROM directors_tbl WHERE name like "%Coppola")),
      (null,'On the Rocks', 2020, (SELECT id FROM directors_tbl WHERE name like "%Coppola")),
      (null,'The Virgin Suicides', 1999, (SELECT id FROM directors_tbl WHERE name like "%Coppola")),
      (null,'Broken Flowers', 2005, (SELECT id FROM directors_tbl WHERE name like "%Jarmusch"))
;
       
-- If you want to update some value
UPDATE directors_tbl SET name = "Christopher Nolan" WHERE id = 3; 

-- Create your Actors table
CREATE TABLE main_actors_tbl(
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255),
    year_of_birth int,
    sex varchar(1),
    PRIMARY KEY (id)
);

INSERT INTO main_actors_tbl
VALUES (null, "Arnold Schwarzenegger", 1947, "M"),
       (null, "Gal Gadot",             1985, "F"),
       (null, "Sigourney Weaver",      1949, "F"),
       (null, "Christian Bale",        1974, "M"),
       (null, "Leonardo DiCaprio",     1974, "M"),
       (null, "Angelina Jolie",        1975, "F"),
       (null, "Zoe Saldaña",           1978, "F"),
       (null, "Gemma Chan",            1982, "F")
;

INSERT INTO main_actors_tbl
VALUES (null, "Bill Murray", null, "M"),
       (null, "Kirsten Dunst", null, "F")
;

INSERT INTO main_actors_tbl
VALUES (null, "玄理", 1986, "F"),
       (null, "西島秀俊", 1971, "M")
;       

-- Create your Movie-Actors table
CREATE TABLE movie_actors_tbl(
    movie_id int NOT NULL,
    main_actor_id int NOT NULL,
    PRIMARY KEY (movie_id, main_actor_id),
    FOREIGN KEY (movie_id) REFERENCES movies_tbl(id),
    FOREIGN KEY (main_actor_id) REFERENCES main_actors_tbl(id)
);

INSERT INTO movie_actors_tbl
VALUES (
    (SELECT id FROM movies_tbl WHERE title LIKE "Avatar"),
    (SELECT id FROM main_actors_tbl WHERE name LIKE "Zo%")
);

INSERT INTO movie_actors_tbl
VALUES (
    (SELECT id FROM movies_tbl WHERE title = 'The Dark Knight'),
    (SELECT id FROM main_actors_tbl WHERE name LIKE "Chri%")
),
(
    (SELECT id FROM movies_tbl WHERE title LIKE "Inc%"),
    (SELECT id FROM main_actors_tbl WHERE name LIKE "Leo%")
),
(
    (SELECT id FROM movies_tbl WHERE title LIKE "Eter%"),
    (SELECT id FROM main_actors_tbl WHERE name LIKE "Angel%")
),
(
    (SELECT id FROM movies_tbl WHERE title LIKE "Ali%"),
    (SELECT id FROM main_actors_tbl WHERE name LIKE "Sig%")
),
(
    (SELECT id FROM movies_tbl WHERE title LIKE "Cleo%"),
    (SELECT id FROM main_actors_tbl WHERE name LIKE "Gal G%")
),
(
    (SELECT id FROM movies_tbl WHERE title = "Eternals"),
    (SELECT id FROM main_actors_tbl WHERE name LIKE "Gem%")
);

INSERT INTO movie_actors_tbl
VALUES (
    (SELECT id FROM movies_tbl WHERE title LIKE "Lost%"),
    (SELECT id FROM main_actors_tbl WHERE name LIKE "Bill%")
),
(
    (SELECT id FROM movies_tbl WHERE title LIKE "On the%"),
    (SELECT id FROM main_actors_tbl WHERE name LIKE "Bill%")
),
(
    (SELECT id FROM movies_tbl WHERE title LIKE "The V%"),
    (SELECT id FROM main_actors_tbl WHERE name LIKE "Kirs%")
),
(
    (SELECT id FROM movies_tbl WHERE title LIKE "Broken%"),
    (SELECT id FROM main_actors_tbl WHERE name LIKE "Bill%")
);

INSERT INTO movie_actors_tbl
VALUES (
    (SELECT id FROM movies_tbl WHERE title = "Titanic"),
    (SELECT id FROM main_actors_tbl WHERE name = "Leonardo DiCaprio")
),
(
    (SELECT id FROM movies_tbl WHERE title = "Wonder Woman"),
    (SELECT id FROM main_actors_tbl WHERE name = "Gal Gadot")
),
(
    (SELECT id FROM movies_tbl WHERE title = "Terminator"),
    (SELECT id FROM main_actors_tbl WHERE name = "Arnold Schwarzenegger")
),
(
    (SELECT id FROM movies_tbl WHERE title = "Avatar"),
    (SELECT id FROM main_actors_tbl WHERE name = "Sigourney Weaver")
);


