DROP TABLE IF EXISTS bounties;

CREATE TABLE bounties (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  species VARCHAR(255),
  last_know_location VARCHAR(255),
  favourite_weapon VARCHAR(255)
);
