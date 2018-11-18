# Level 2

To be as competitive as possible, we decide to have a decreasing pricing for longer rentals.

New rules:

- price per day decreases by 10% after 1 day
- price per day decreases by 30% after 4 days
- price per day decreases by 50% after 10 days

Adapt the rental price computation to take these new rules into account.

# Code related design decisions

* Introduced a new `Rental calculator` class that is respnsible to calculate the rental based on the applicable discount, vehicle booking rate and number of days of travel.

* Isolated the instance creation related to the `Rental Calculator` class so that the rental calculator related instance is created only when it's invokved via the `book` method.
