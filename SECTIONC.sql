CREATE TABLE IF NOT EXISTS Users(
user_id integer PRIMARY KEY,
user_name varchar,
user_email varchar
);

CREATE TABLE IF NOT EXISTS Cities(
city_id integer PRIMARY KEY,
city_name varchar
);

CREATE TABLE IF NOT EXISTS Theatres(
theatre_id integer PRIMARY KEY,
theatre_name varchar,
city_id integer,
FOREIGN KEY (city_id) REFERENCES Cities (city_id)
);
CREATE TABLE IF NOT EXISTS Screens (
screen_id integer PRIMARY KEY,
theatre_id integer,
FOREIGN KEY (theatre_id) REFERENCES Theatres (theatre_id)
);

CREATE TABLE IF NOT EXISTS Movies(
movie_id integer PRIMARY KEY,
movie_name varchar,
language varchar,
genre varchar
);

CREATE TABLE IF NOT EXISTS Shows(
show_id integer PRIMARY KEY,
movie_id integer,
screen_id integer,
show_time DATETIME,
price decial(10,2),
FOREIGN KEY (movie_id) REFERENCES Movies (movie_id),
FOREIGN KEY (screen_id) REFERENCES Screens (screen_id)
);
CREATE TABLE IF NOT EXISTS Bookings(
booking_id integer PRIMARY KEY,
show_id integer,
total price decimal(10,2),
payment_status varchar,
FOREIGN KEY (show_id) REFERENCES Shows (show_id)
);
CREATE TABLE IF NOT EXISTS Seats(
seat_id integer PRIMARY KEY,
screen_id integer,
seat_type varchar,
FOREIGN KEY (screen_id) REFERENCES Screens (screen_id)
);
CREATE TABLE IF NOT EXISTS Booking_Users(
booking_id integer,
user_id integer,
PRIMARY KEY (booking_id, user_id),
FOREIGN KEY (booking_id) REFERENCES Bookings (booking_id),
FOREIGN KEY (user_id) REFERENCES Users (user_id)
);
CREATE TABLE IF NOT EXISTS Booking_Seats (
booking_id integer,
user_id integer,
seat_id integer,
PRIMARY KEY (booking_id, seat_id),
FOREIGN KEY (booking_id) REFERENCES Bookings (booking_id),
FOREIGN KEY (user_id) REFERENCES Users (user_id),
FOREIGN KEY (seat_id) REFERENCES Seats (seat_id)
);

INSERT INTO Users VALUES (1, 'Asha', 'asha@gmail.com');
INSERT INTO Users VALUES (2, 'Rahul', 'rahul@gmail.com');

INSERT INTO Cities VALUES (1, 'Bangalore');

INSERT INTO Theatres VALUES (1, 'PVR Orion', 1);

INSERT INTO Screens VALUES (1, 1);

INSERT INTO Movies VALUES (1, 'Avengers', 'English', 'Action');
INSERT INTO Movies VALUES (2, 'Inception', 'English', 'Sci-Fi');

INSERT INTO Shows VALUES (1, 1, 1, '2026-04-28 10:00:00', 200);
INSERT INTO Shows VALUES (2, 2, 1, '2026-04-28 14:00:00', 250);

INSERT INTO Seats VALUES (1, 1, 'VIP');
INSERT INTO Seats VALUES (2, 1, 'Regular');
INSERT INTO Seats VALUES (3, 1, 'Regular');

INSERT INTO Bookings VALUES (1, 1, 350, 'CONFIRMED');
INSERT INTO Bookings VALUES (2, 2, 250, 'CONFIRMED');

INSERT INTO Booking_Users VALUES (1, 1);
INSERT INTO Booking_Users VALUES (2, 2);

INSERT INTO Booking_Seats VALUES (1, 1, 1);
INSERT INTO Booking_Seats VALUES (1, 1, 2);
INSERT INTO Booking_Seats VALUES (2, 2, 3);

SELECT 
  b.booking_id,
  m.movie_name,
  t.theatre_name,
  s.show_time,
  se.seat_id
FROM Users u
JOIN Booking_Users bu ON u.user_id = bu.user_id
JOIN Bookings b ON bu.booking_id = b.booking_id
JOIN Shows s ON b.show_id = s.show_id
JOIN Movies m ON s.movie_id = m.movie_id
JOIN Screens sc ON s.screen_id = sc.screen_id
JOIN Theatres t ON sc.theatre_id = t.theatre_id
JOIN Booking_Seats bs ON b.booking_id = bs.booking_id
JOIN Seats se ON bs.seat_id = se.seat_id
WHERE u.user_id = 1
AND s.show_time BETWEEN '2026-04-28 00:00:00' AND '2026-04-28 23:59:59';

SELECT 
  m.movie_name,
  COUNT(b.booking_id) AS total_bookings
FROM Bookings b
JOIN Shows s ON b.show_id = s.show_id
JOIN Movies m ON s.movie_id = m.movie_id
GROUP BY m.movie_name;

SELECT 
  s.show_id,
  s.show_time,
  COUNT(bs.seat_id) AS booked_seats,
  (3 - COUNT(bs.seat_id)) AS available_seats
FROM Shows s
LEFT JOIN Bookings b ON s.show_id = b.show_id
LEFT JOIN Booking_Seats bs ON b.booking_id = bs.booking_id
GROUP BY s.show_id;



SELECT * FROM Shows;
SELECT * FROM Movies;
SELECT * FROM Booking_Seats;


