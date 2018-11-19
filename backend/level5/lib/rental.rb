# frozen_string_literal: true

require 'date'
require_relative 'rental_calculator'
require_relative 'commission_calculator'
require_relative 'payment_allocator'
require_relative 'additional_features_calculator'

class Rental
  attr_reader :allocated_payments

  PAYMENT_CALCULATORS = {
    'rental' => RentalCalculator,
    'commission' => CommissionCalculator,
    'allocator' => PaymentAllocator,
    'additional_features' => AdditionalFeaturesCalculator
  }.freeze

  def initialize(booking_info, vehicle, additional_features)
    @id = booking_info['id']
    @vehicle = vehicle
    @start_date = Date.strptime(booking_info['start_date'])
    @end_date = Date.strptime(booking_info['end_date'])
    @distance = booking_info['distance']
    @additional_features = additional_features
  end

  def book
    price = rental_calculator(vehicle.booking_rate, number_of_days, distance).calculate_travel_cost
    commission = commission_calculator(price, number_of_days).calculate
    additional_features_cost = additional_features_calculator(additional_features, number_of_days).calculate
    @allocated_payments = payment_allocator(price, commission, additional_features_cost).allocate
  end

  def payment_details
    {
      id: id,
      options: additional_features.map(&:name),
      actions: allocated_payments
    }
  end

  private

    attr_reader :vehicle, :distance, :end_date, :start_date, :id, :additional_features

    def number_of_days
      (end_date - start_date).to_i + 1
    end

    def commission_calculator(price, number_of_days)
      @commission_calculator ||= CommissionCalculator.new(price, number_of_days)
    end

    def rental_calculator(vehicle_booking_rate, number_of_days, distance)
      @rental_calculator ||= RentalCalculator.new(vehicle_booking_rate, number_of_days, distance)
    end

    def payment_allocator(price, commission, additional_features_cost)
      @payment_allocator ||= PaymentAllocator.new(price, commission, additional_features_cost)
    end

    def additional_features_calculator(additional_features, number_of_days)
      @additional_features_calculator ||= AdditionalFeaturesCalculator.new(additional_features, number_of_days)
    end
end
