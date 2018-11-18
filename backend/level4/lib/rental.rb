# frozen_string_literal: true

require 'date'
require_relative 'rental_calculator'
require_relative 'commission_calculator'
require_relative 'payment_allocator'

class Rental
  attr_accessor :allocated_payments

  def initialize(booking_info, vehicle)
    @id = booking_info['id']
    @vehicle = vehicle
    @start_date = Date.strptime(booking_info['start_date'])
    @end_date = Date.strptime(booking_info['end_date'])
    @distance = booking_info['distance']
  end

  def book
    price = rental_calculator(vehicle.booking_rate, number_of_days, distance).calculate_travel_cost
    commission = commission_calculator(price, number_of_days).calculate
    @allocated_payments = payment_allocator(price, commission).allocate
  end

  def payment_details
    {
      id: id,
      actions: allocated_payments
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

    def payment_allocator(price, commission)
      @payment_allocator ||= PaymentAllocator.new(price, commission)
    end
end
