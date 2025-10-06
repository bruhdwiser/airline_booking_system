-- Sample data for development
INSERT INTO airlines (id, code, name) VALUES (1, 'AA', 'American Airlines') ON DUPLICATE KEY UPDATE name=VALUES(name);
INSERT INTO airlines (id, code, name) VALUES (2, 'BA', 'British Airways') ON DUPLICATE KEY UPDATE name=VALUES(name);

INSERT INTO airports (id, code, name, city, country) VALUES (1, 'JFK', 'John F. Kennedy International Airport', 'New York', 'USA') ON DUPLICATE KEY UPDATE name=VALUES(name), city=VALUES(city), country=VALUES(country);
INSERT INTO airports (id, code, name, city, country) VALUES (2, 'LHR', 'Heathrow Airport', 'London', 'UK') ON DUPLICATE KEY UPDATE name=VALUES(name), city=VALUES(city), country=VALUES(country);
INSERT INTO airports (id, code, name, city, country) VALUES (3, 'SFO', 'San Francisco International Airport', 'San Francisco', 'USA') ON DUPLICATE KEY UPDATE name=VALUES(name), city=VALUES(city), country=VALUES(country);

INSERT INTO flights (id, flight_number, airline_id, from_airport_id, to_airport_id, departure_time, arrival_time, price, seats_available)
VALUES (1, 'AA100', 1, 1, 2, '2025-12-01 08:00:00', '2025-12-01 20:00:00', 550.00, 50)
ON DUPLICATE KEY UPDATE price=VALUES(price), seats_available=VALUES(seats_available), departure_time=VALUES(departure_time), arrival_time=VALUES(arrival_time);

INSERT INTO flights (id, flight_number, airline_id, from_airport_id, to_airport_id, departure_time, arrival_time, price, seats_available)
VALUES (2, 'BA200', 2, 2, 1, '2025-12-02 09:00:00', '2025-12-02 18:30:00', 520.00, 60)
ON DUPLICATE KEY UPDATE price=VALUES(price), seats_available=VALUES(seats_available), departure_time=VALUES(departure_time), arrival_time=VALUES(arrival_time);
