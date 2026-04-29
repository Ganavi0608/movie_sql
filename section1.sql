CREATE TABLE IF NOT EXISTS Users(
user_id integer PRIMARY KEY,
user_name varchar,
user_email varchar 
);


CREATE TABLE IF NOT EXISTS Movies(
movie_id integer PRIMARY KEY,
movie_name varchar
);


CREATE TABLE IF NOT EXISTS Theatres(
theatre_id integer PRIMARY KEY,
theatre_name varchar,
theatre_location varchar
);

CREATE TABLE IF NOT EXISTS Shows (
show_id integer PRIMARY KEY,
movie_id integer ,
theatre_id integer,
show_time DATETIME,
FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
FOREIGN KEY (theatre_id) REFERENCES Theatres(theatre_id)
);

CREATE TABLE IF NOT EXISTS Bookings (
booking_id integer PRIMARY KEY,
user_id integer,
show_id integer,
total_price integer,
payment_status varchar,
FOREIGN KEY (user_id) REFERENCES Users(user_id),
FOREIGN KEY (show_id) REFERENCES Shows(show_id)

);

CREATE TABLE IF NOT EXISTS Booking_Seats (
booking_id integer,
seat_number varchar,
FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

