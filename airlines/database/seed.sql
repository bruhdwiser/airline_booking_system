USE airline_booking;

INSERT INTO airlines (code, name) VALUES
 ('AA', 'American Airlines')
,('BA', 'British Airways')
ON DUPLICATE KEY UPDATE name=VALUES(name);

INSERT INTO airports (code, name, city, country) VALUES
 ('JFK', 'John F. Kennedy International Airport', 'New York', 'USA')
,('LHR', 'Heathrow Airport', 'London', 'UK')
,('SFO', 'San Francisco International Airport', 'San Francisco', 'USA')
ON DUPLICATE KEY UPDATE name=VALUES(name), city=VALUES(city), country=VALUES(country);

INSERT INTO flights (flight_number, airline_id, from_airport_id, to_airport_id, departure_time, arrival_time, price, seats_available)
SELECT 'AA100', a.id, af.id, at.id, '2025-12-01 08:00:00', '2025-12-01 20:00:00', 550.00, 50
FROM airlines a, airports af, airports at
WHERE a.code='AA' AND af.code='JFK' AND at.code='LHR'
ON DUPLICATE KEY UPDATE price=VALUES(price), seats_available=VALUES(seats_available), departure_time=VALUES(departure_time), arrival_time=VALUES(arrival_time);

INSERT INTO flights (flight_number, airline_id, from_airport_id, to_airport_id, departure_time, arrival_time, price, seats_available)
SELECT 'BA200', a.id, af.id, at.id, '2025-12-02 09:00:00', '2025-12-02 18:30:00', 520.00, 60
FROM airlines a, airports af, airports at
WHERE a.code='BA' AND af.code='LHR' AND at.code='JFK'
ON DUPLICATE KEY UPDATE price=VALUES(price), seats_available=VALUES(seats_available), departure_time=VALUES(departure_time), arrival_time=VALUES(arrival_time);
