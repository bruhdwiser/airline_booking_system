-- Schema for Airline Booking System (MySQL)
CREATE DATABASE IF NOT EXISTS airline_booking DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE airline_booking;

CREATE TABLE IF NOT EXISTS airlines (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS airports (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(3) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS flights (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(50) NOT NULL UNIQUE,
    airline_id BIGINT NOT NULL,
    from_airport_id BIGINT NOT NULL,
    to_airport_id BIGINT NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    seats_available INT NOT NULL,
    CONSTRAINT fk_flight_airline FOREIGN KEY (airline_id) REFERENCES airlines(id),
    CONSTRAINT fk_flight_from_airport FOREIGN KEY (from_airport_id) REFERENCES airports(id),
    CONSTRAINT fk_flight_to_airport FOREIGN KEY (to_airport_id) REFERENCES airports(id)
);

CREATE TABLE IF NOT EXISTS bookings (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    flight_id BIGINT NOT NULL,
    passenger_name VARCHAR(255) NOT NULL,
    passenger_email VARCHAR(255) NOT NULL,
    seats_booked INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_booking_flight FOREIGN KEY (flight_id) REFERENCES flights(id)
);

CREATE INDEX IF NOT EXISTS idx_flights_route_time ON flights (from_airport_id, to_airport_id, departure_time);
