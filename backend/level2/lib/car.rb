# frozen_string_literal: true

class Car
  attr_reader :id

  def initialize(id, price_per_day, price_per_km)
    @id = id
    @price_per_day = price_per_day
    @price_per_km = price_per_km
  end

  def booking_rate
    {
      price_per_day: price_per_day,
      price_per_km: price_per_km
    }
  end

  private
    attr_reader :price_per_day, :price_per_km
end
