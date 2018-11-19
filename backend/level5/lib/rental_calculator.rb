# frozen_string_literal: true

require 'bigdecimal'

class RentalCalculator
  def initialize(vehicle_pricing_info, number_of_days, distance)
    @vehicle_pricing_info = vehicle_pricing_info
    @number_of_days = number_of_days
    @distance = distance
  end

  DAY_RANGE_DISCOUNTS = {
    0..1 => 0,
    2..4 => (1 / BigDecimal.new(10)),
    5..10 => (3 / BigDecimal.new(10)),
    11..Float::INFINITY => (1 / BigDecimal.new(2))
  }.freeze

  def calculate_travel_cost
    price_per_day_with_discounts(vehicle_pricing_info[:price_per_day], number_of_days) +
      vehicle_pricing_info[:price_per_km] * distance
  end

  private

    attr_reader :vehicle_pricing_info, :number_of_days, :distance

    def price_per_day_with_discounts(vehicle_price_per_day, number_of_days)
      total = 0

      (1..number_of_days).each do |day|
        total += discounted_rate(day) * vehicle_price_per_day
      end

      round_if_no_decimals(total)
    end

    def discounted_rate(day)
      days_range = DAY_RANGE_DISCOUNTS.keys.detect { |key| key.include?(day) }
      1 - DAY_RANGE_DISCOUNTS[days_range]
    end

    def round_if_no_decimals(amount)
      amount % 1 == 0 ? amount.to_i : amount
    end
end
