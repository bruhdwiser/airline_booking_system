package com.airline.booking.controller;

import com.airline.booking.dto.BookingRequest;
import com.airline.booking.entity.Booking;
import com.airline.booking.entity.Flight;
import com.airline.booking.repository.BookingRepository;
import com.airline.booking.repository.FlightRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.Optional;

@RestController
@RequestMapping("/api/bookings")
public class BookingController {
    private final BookingRepository bookingRepository;
    private final FlightRepository flightRepository;

    public BookingController(BookingRepository bookingRepository, FlightRepository flightRepository) {
        this.bookingRepository = bookingRepository;
        this.flightRepository = flightRepository;
    }

    @PostMapping
    public ResponseEntity<Booking> create(@RequestBody BookingRequest req) {
        Optional<Flight> flightOpt = flightRepository.findById(req.getFlightId());
        if (flightOpt.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        Flight flight = flightOpt.get();
        if (req.getSeats() == null || req.getSeats() <= 0) {
            return ResponseEntity.badRequest().build();
        }
        if (flight.getSeatsAvailable() < req.getSeats()) {
            return ResponseEntity.unprocessableEntity().build();
        }
        flight.setSeatsAvailable(flight.getSeatsAvailable() - req.getSeats());
        flightRepository.save(flight);

        Booking booking = new Booking();
        booking.setFlight(flight);
        booking.setPassengerName(req.getPassengerName());
        booking.setPassengerEmail(req.getPassengerEmail());
        booking.setSeatsBooked(req.getSeats());
        booking.setStatus("CONFIRMED");

        Booking saved = bookingRepository.save(booking);
        return ResponseEntity.created(URI.create("/api/bookings/" + saved.getId())).body(saved);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Booking> get(@PathVariable Long id) {
        return bookingRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}
