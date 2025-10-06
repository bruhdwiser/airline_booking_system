# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

Repository overview
- Monorepo with three parts:
  - backend/: Spring Boot (Java 17, Maven) REST API using Spring Data JPA and MySQL
  - frontend/: static HTML/CSS/JS that calls the backend at http://localhost:8080/api
  - database/: SQL schema and seed scripts for manual DB setup
- Prerequisites: Java 17+, Maven (or the included Maven Wrapper), MySQL 8+

Common commands
Backend (run from backend/)
- Build (jar):
  - Windows PowerShell: .\mvnw.cmd clean package
  - Bash (macOS/Linux): ./mvnw clean package
- Run (dev):
  - Ensure DB env vars are set if needed (defaults are MYSQL_USERNAME=root, MYSQL_PASSWORD="")
  - Windows PowerShell:
    $env:MYSQL_USERNAME = 'root'
    $env:MYSQL_PASSWORD = '{{MYSQL_PASSWORD}}'
    .\mvnw.cmd spring-boot:run
  - Bash (macOS/Linux):
    export MYSQL_USERNAME=root
    export MYSQL_PASSWORD={{MYSQL_PASSWORD}}
    ./mvnw spring-boot:run
- Run built jar (after build):
  - Windows PowerShell: java -jar .\target\backend-0.0.1-SNAPSHOT.jar
  - Bash (macOS/Linux): java -jar ./target/backend-0.0.1-SNAPSHOT.jar
- Run all tests:
  - Windows PowerShell: .\mvnw.cmd test
  - Bash (macOS/Linux): ./mvnw test
- Run a single test:
  - Class: .\mvnw.cmd -Dtest=AirlineBookingApplicationTests test
  - Single method: .\mvnw.cmd -Dtest=AirlineBookingApplicationTests#contextLoads test
  - (Bash/macOS/Linux: replace .\mvnw.cmd with ./mvnw)

Database
- The app connects to MySQL at jdbc:mysql://localhost:3306/airline_booking (configurable in backend/src/main/resources/application.properties)
- Environment variables supported in application properties:
  - MYSQL_USERNAME (default: root)
  - MYSQL_PASSWORD (default: empty)
- On first run, schema is managed by JPA (spring.jpa.hibernate.ddl-auto=update) and sample data loads from backend/src/main/resources/data.sql
- Optional: apply SQL scripts manually using the MySQL CLI
  - Windows PowerShell (avoid inline secrets; set MYSQL_PWD beforehand):
    $env:MYSQL_PWD = '{{MYSQL_PASSWORD}}'
    mysql -u {{MYSQL_USERNAME}} -e "SOURCE database/schema.sql; SOURCE database/seed.sql;"

Frontend
- Static site: open frontend/index.html in a browser
- It calls the backend API at http://localhost:8080/api (CORS is enabled for development)

API surface (high-level)
- GET /api/airports → list airports
- GET /api/flights/search?from=JFK&to=LHR&date=YYYY-MM-DD → search flights by route and date
- POST /api/bookings → create a booking
  - body: { flightId, passengerName, passengerEmail, seats }
- GET /api/bookings/{id} → fetch a booking by ID

Architecture
- Backend (Spring Boot)
  - Entry point: com.airline.booking.AirlineBookingApplication
  - Controllers (HTTP layer): AirportController, FlightController, BookingController
    - Map JSON REST endpoints under /api/*
  - Data layer: Spring Data JPA repositories (AirportRepository, FlightRepository, BookingRepository)
    - FlightRepository.search uses JPQL to filter by IATA codes and departure window
  - Domain model: JPA entities (Airline, Airport, Flight, Booking) mapped to MySQL tables
  - Configuration: WebConfig enables permissive CORS for development
  - Configuration file: backend/src/main/resources/application.properties (server.port=8080; JPA + datasource)
- Frontend
  - index.html + app.js + styles.css; app.js defines API_BASE='http://localhost:8080/api' and drives search/booking flow
- Database
  - schema.sql and seed.sql under database/ for manual setup; runtime dev data via backend/src/main/resources/data.sql

Notes from README
- Tech stack: Frontend (HTML/CSS/JS), Backend (Java/Spring Boot/Maven), Database (MySQL)
- Getting started prerequisites match the versions above
- Backend can be run with the Maven Spring Boot plugin; frontend is static
