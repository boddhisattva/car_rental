require 'date'
class Rental

  attr_accessor :price

  def initialize(booking_info, vehicle)
    @id = booking_info["id"]
    @vehicle = vehicle
    @start_date = Date.strptime(booking_info["start_date"])
    @end_date = Date.strptime(booking_info["end_date"])
    @distance = booking_info["distance"]
    @price = nil
  end

  def book
    self.price = calculate_travel_cost(vehicle.booking_rate)
  end

  def booking_details
    {
      id: id,
      price: price
    }
  end

  private

    attr_reader :vehicle, :end_date, :start_date, :distance, :id

    def calculate_travel_cost(vehicle_booking_info)
      vehicle_booking_info[:price_per_day] * number_of_days +
      vehicle_booking_info[:price_per_km] * distance
    end

    def number_of_days
      (end_date - start_date).to_i + 1
    end
end