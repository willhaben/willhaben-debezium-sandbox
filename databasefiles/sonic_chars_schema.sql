CREATE TABLE character (
    id serial PRIMARY KEY,
    name VARCHAR(200) UNIQUE NOT NULL,
    race VARCHAR(200)
);

CREATE TABLE game (
    id serial PRIMARY KEY,
    title VARCHAR(200) UNIQUE NOT NULL,
    platform VARCHAR(255)
);

CREATE TABLE game_appearance (
    character_id INT NOT NULL,
    game_id INT NOT NULL,
    PRIMARY KEY(character_id, game_id),
    FOREIGN KEY (character_id) REFERENCES character(id),
    FOREIGN KEY (game_id) REFERENCES game(id)
);