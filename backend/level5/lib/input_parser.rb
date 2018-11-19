# frozen_string_literal: true

require 'json'
require_relative 'car'
require_relative 'rental'
require_relative 'additional_feature'

class InputParser
  CARS_ENTITY_NAME = 'cars'
  RENTALS_ENTITY_NAME = 'rentals'
  ADDITIONAL_FEATURES_ENTITY_NAME = 'options'

  def initialize(file_parser, data_validator)
    @file_parser = file_parser
    @data_validator = data_validator
  end

  def parse
    input = file_parser.parse
    cars = parse_cars_info(input[CARS_ENTITY_NAME])
    additional_features = parse_additional_features(input['options'])
    parse_rentals_info(cars, additional_features, input['rentals'])
  end

  private

    attr_reader :file_parser, :data_validator

    def parse_cars_info(cars)
      cars.map do |car|
        data_validator.validate(car, CARS_ENTITY_NAME)
        Car.new(car['id'], car['price_per_day'], car['price_per_km'])
      end
    end

    def parse_additional_features(options)
      options.map do |option|
        data_validator.validate(option, ADDITIONAL_FEATURES_ENTITY_NAME)
        AdditionalFeature.new(option['id'], option['rental_id'], option['type'])
      end
    end

    def parse_rentals_info(cars, additional_features, rentals)
      rentals.map do |rental|
        data_validator.validate(rental, RENTALS_ENTITY_NAME)
        car = cars.detect { |car| car.id == rental['car_id'] }
        additional_features_for_rental = additional_features.select { |feature| feature.rental_id == rental['id'] }
        rental.delete('car_id')
        Rental.new(rental, car, additional_features_for_rental)
      end
    end
end
