CREATE TABLE accounts (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	token VARCHAR ( 50 ),
	created_on TIMESTAMP NOT NULL,
    last_login TIMESTAMP 
);

CREATE TABLE operations (
  operation_id serial PRIMARY KEY,
  user_id INT REFERENCES accounts(user_id),
  first_value INT NOT NULL,
  second_value INT NOT NULL,
  result_value INT NOT NULL,
  created_on TIMESTAMP NOT NULL
);

