DROP TABLE IF EXISTS properties;

CREATE TABLE properties(
  id SERIAL8,
  address VARCHAR(255),
  value INT4,
  no_of_bedrooms INT2,
  year_built INT2,
  build VARCHAR(255)
);
