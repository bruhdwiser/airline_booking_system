package com.airline.booking.dto;

public class BookingRequest {
    private Long flightId;
    private String passengerName;
    private String passengerEmail;
    private Integer seats;

    public Long getFlightId() { return flightId; }
    public void setFlightId(Long flightId) { this.flightId = flightId; }

    public String getPassengerName() { return passengerName; }
    public void setPassengerName(String passengerName) { this.passengerName = passengerName; }

    public String getPassengerEmail() { return passengerEmail; }
    public void setPassengerEmail(String passengerEmail) { this.passengerEmail = passengerEmail; }

    public Integer getSeats() { return seats; }
    public void setSeats(Integer seats) { this.seats = seats; }
}
