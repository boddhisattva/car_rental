# frozen_string_literal: true

require 'json'
require_relative 'car'
require_relative 'rental'
require_relative 'rental_calculator'

class FileParser
  def initialize(file_name)
    @file_name = file_name
  end

  def parse
    input = read_data(file_name)
    cars = parse_cars_info(input['cars'])
    parse_rentals_info(cars, input['rentals'])
  end

  private

    attr_reader :file_name

    def read_data(file_name)
      input = ''

      File.foreach(file_name) do |line|
        input += line
      end

      JSON.parse(input)
    end

    def parse_cars_info(cars)
      cars.map do |car|
        Car.new(car['id'], car['price_per_day'], car['price_per_km'])
      end
    end

    def parse_rentals_info(cars, rentals)
      rentals.map do |rental|
        car = cars.detect { |car| car.id == rental['car_id'] }
        rental.delete('car_id')
        Rental.new(rental, car)
      end
    end
end
