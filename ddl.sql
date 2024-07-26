CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE files (
  id SERIAL PRIMARY KEY,
  file_name VARCHAR(255) NOT NULL,
  url VARCHAR(255) NOT NULL,
  mime_type VARCHAR(50) NOT NULL, 
  key INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  user_id INTEGER NOT NULL REFERENCES users(id)
);

CREATE TABLE Countries (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE people (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    biography TEXT,
    birthday DATE,
    gender VARCHAR(10) NOT NULL,
    country_id INTEGER,
    FOREIGN KEY (country_id) REFERENCES countries(id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE movies (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  budget INTEGER NOT NULL,
  release_date DATE NOT NULL,
  duration INTEGER NOT NULL,
  director_id INTEGER,
  country_id INTEGER,
  poster_id INTEGER,
  FOREIGN KEY (director_id) REFERENCES people(id),
  FOREIGN KEY (country_id) REFERENCES countries(id),
  FOREIGN KEY (poster_id) REFERENCES files(id)
);

CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE movies_genres (
    movie_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE characters (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    role VARCHAR(20) NOT NULL CHECK (role IN ('leading', 'supporting', 'background')),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
   );

CREATE TABLE movies_characters (
    movie_id INTEGER NOT NULL,
    character_id INTEGER NOT NULL,
    PRIMARY KEY (movie_id, character_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (character_id) REFERENCES characters(id)
);

CREATE TABLE characters_people (
    character_id INTEGER NOT NULL,
    people_id INTEGER NOT NULL,
    PRIMARY KEY (character_id, people_id),
    FOREIGN KEY (people_id) REFERENCES people(id),
    FOREIGN KEY (character_id) REFERENCES characters(id)
);

CREATE TABLE favorite_movies (
    user_id INTEGER NOT NULL,
    movie_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);