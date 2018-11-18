# Intro

We are building a peer-to-peer car rental service. Let's call it Drivy :)

Here is our plan:

- Let any car owner list her car on our platform
- Let any person (let's call him 'driver') book a car for given dates/distance

# Level 1

The car owner chooses a price per day and price per km for her car.
The driver then books the car for a given period and an approximate distance.

The rental price is the sum of:

- A time component: the number of rental days multiplied by the car's price per day
- A distance component: the number of km multiplied by the car's price per km

# Code related design decisions

* The entities related to this leve of the problem domain are - `Rental`, `Car`

* Each Rental Service is associated with a vehicle which in our case is a car. Since a Rental has a vehicle, I've made use of composition here.

* The code `vehicle.booking_rate` basically represents a duck type and we could calculate the Rental for any vehicle that responds to the `booking_rate` message which would have price per day and price per km related details.

* Made use of a `FileParser` class to read the input data