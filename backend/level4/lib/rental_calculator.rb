# frozen_string_literal: true

class RentalCalculator

  def initialize(vehicle_pricing_info, number_of_days, distance)
    @vehicle_pricing_info = vehicle_pricing_info
    @number_of_days = number_of_days
    @distance = distance
  end

  DAY_RANGE_DISCOUNTS = {
    0..1 => 0,
    2..4 => 0.1,
    5..10 => 0.3,
    11..Float::INFINITY => 0.5
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

      total % 1 == 0 ? total.to_i : total
    end

    def discounted_rate(day)
      days_range = DAY_RANGE_DISCOUNTS.keys.detect { |key| key.include?(day) }
      1 - DAY_RANGE_DISCOUNTS[days_range]
    end
end
