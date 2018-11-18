# frozen_string_literal: true

require 'date'
require_relative 'rental_calculator'
require_relative 'commission_calculator'

class Rental
  attr_accessor :price, :commission

  def initialize(booking_info, vehicle)
    @id = booking_info['id']
    @vehicle = vehicle
    @start_date = Date.strptime(booking_info['start_date'])
    @end_date = Date.strptime(booking_info['end_date'])
    @distance = booking_info['distance']
  end

  def book
    @price = rental_calculator(vehicle.booking_rate, number_of_days, distance).calculate_travel_cost
    @commission = commission_calculator(price, number_of_days).calculate
  end

  def booking_details
    {
      id: id,
      price: price,
      commission: commission
    }
  end

  private

    attr_reader :vehicle, :end_date, :start_date, :distance, :id, :rental_calculator

    def number_of_days
      (end_date - start_date).to_i + 1
    end

    def commission_calculator(price, number_of_days)
      @commission_calculator ||= CommissionCalculator.new(price, number_of_days)
    end

    def rental_calculator(vehicle_booking_rate, number_of_days, distance)
      @rental_calculator ||= RentalCalculator.new(vehicle_booking_rate, number_of_days, distance)
    end
end
