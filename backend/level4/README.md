# Level 4

We now want to know how much money must be debited/credited for each actor, this will allow us to debit or pay them accordingly.

# Code related design decisions

* Added an `Actor` class to maintain payment type and amount associated with each actor
  * Kept the payment type to be `credit` when instantiating a new actor because most actors are entitled to get a payment credit
* Added a `PaymentAllocator` class to allocate payments associated with each actor
  * The `PaymentAllocator` has a collection of fixed and other actors that may change from time to time
    * Fixed actors include - Driver and Owner
    * Other actors is more of a dynamic collection of actors which are currently created based on the set of actors to whom a commission amount is due.
      * This way if we have more actors that are entitled to commission the payment allocation for each such actor should be calculatable easily without potentially having to change any code