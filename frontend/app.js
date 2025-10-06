const API_BASE = 'http://localhost:8080/api';

const resultsEl = document.getElementById('results');
const searchForm = document.getElementById('search-form');
const bookingForm = document.getElementById('booking-form');
const bookBtn = document.getElementById('book-btn');

let selectedFlight = null;

searchForm.addEventListener('submit', async (e) => {
  e.preventDefault();
  resultsEl.textContent = 'Searching...';
  const from = document.getElementById('from').value.trim().toUpperCase();
  const to = document.getElementById('to').value.trim().toUpperCase();
  const date = document.getElementById('date').value;

  try {
    const res = await fetch(`${API_BASE}/flights/search?from=${from}&to=${to}&date=${date}`);
    if (!res.ok) throw new Error('Search failed');
    const flights = await res.json();
    if (!flights.length) {
      resultsEl.textContent = 'No flights found';
      return;
    }
    resultsEl.innerHTML = '';
    flights.forEach(f => {
      const div = document.createElement('div');
      div.className = 'flight';
      div.innerHTML = `
        <div>
          <div><strong>${f.flightNumber}</strong> — ${f.airline.name}</div>
          <div class="meta">${f.fromAirport.code} → ${f.toAirport.code}</div>
          <div class="meta">Departure: ${f.departureTime.replace('T',' ')} | Arrival: ${f.arrivalTime.replace('T',' ')}</div>
          <div class="meta">Price: $${f.price} | Seats: ${f.seatsAvailable}</div>
        </div>
        <div>
          <button data-id="${f.id}">Select</button>
        </div>
      `;
      div.querySelector('button').addEventListener('click', () => selectFlight(f));
      resultsEl.appendChild(div);
    });
  } catch (err) {
    resultsEl.textContent = err.message;
  }
});

function selectFlight(flight) {
  selectedFlight = flight;
  document.getElementById('flightId').value = flight.id;
  document.getElementById('selected-flight').textContent = `Selected: ${flight.flightNumber} ${flight.fromAirport.code}→${flight.toAirport.code} | $${flight.price}`;
  bookBtn.disabled = false;
}

bookingForm.addEventListener('submit', async (e) => {
  e.preventDefault();
  if (!selectedFlight) return;
  bookBtn.disabled = true;

  const payload = {
    flightId: selectedFlight.id,
    passengerName: document.getElementById('name').value,
    passengerEmail: document.getElementById('email').value,
    seats: parseInt(document.getElementById('seats').value, 10)
  };
  try {
    const res = await fetch(`${API_BASE}/bookings`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    });
    if (!res.ok) throw new Error('Booking failed');
    const booking = await res.json();
    document.getElementById('booking-result').textContent = `Success! Booking ID: ${booking.id}`;
  } catch (err) {
    document.getElementById('booking-result').textContent = err.message;
  } finally {
    bookBtn.disabled = false;
  }
});
