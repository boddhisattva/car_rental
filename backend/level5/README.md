# Level 5

Some drivers want to be able to buy additionnal features after their booking.

Here are the possible options:
- GPS: 5€/day, all the money goes to the owner
- Baby Seat: 2€/day, all the money goes to the owner
- Additional Insurance: 10€/day, all the money goes to Drivy

_This is the final level, now would be a good time to tidy up your code and do a last round of refactoring :)_


# Code related design decisions

* Use `BigDecimal` class in Ruby to represent money related values in a more accurate manner
* Added an `AdditionalFeature` related class to maintain basic information related to each option/additional feature, it's beneficiary and the associated cost and corresponding day information. This class also computes the per day cost related information to each additional feature.
* Added an `AdditionalFeaturesCalculator` related class to calculate the cost associated with each feature based on the number of days of travel
* Appropriate changes are made to `PaymentAllocator` class to account for the additional costs to be
credited or debited with regard to each of the actors in the context of the additional features
* Added a `DataValidator` class to check if any of the input attributes(present in `data/input.json`) with regard to each of the entities - `cars`, `rentals` or `options` are missing or have nil values. To do this check, the `DataValidator` class uses a user supplied file called `input_required_attributes.json` which maintains a list of required attributes with regard to each entity
  * The intent of doing a data validation is to prevent execution of the program if the input data is invalid in any way
  * The advantage of maintaining a separate file to supply information with regard to required attributes is that if we need to add or remove required attributes with regard to any of these entities we only need to modify the `input_required_attributes.json` file and we wouldn't need to touch any code in the `DataValidator` class or any other classs for that matter
* Separated `FileParser` into `InputParser` and `JsonFileParser` to separate the responsibility of parsing input from parsing JSON. Also this way the `JsonFileParser` related code can be reused to read the contents of the required attributes file(i.e., `data/input_required_attributes.json`).