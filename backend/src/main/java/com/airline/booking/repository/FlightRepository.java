package com.airline.booking.repository;

import com.airline.booking.entity.Flight;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface FlightRepository extends JpaRepository<Flight, Long> {
    @Query("SELECT f FROM Flight f WHERE f.fromAirport.code = :from AND f.toAirport.code = :to AND f.departureTime BETWEEN :start AND :end")
    List<Flight> search(@Param("from") String from,
                        @Param("to") String to,
                        @Param("start") LocalDateTime start,
                        @Param("end") LocalDateTime end);
}
