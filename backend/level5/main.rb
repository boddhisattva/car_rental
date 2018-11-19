# frozen_string_literal: true

require_relative 'lib/input_parser'
require_relative 'lib/json_file_parser'
require_relative 'lib/data_validator'

file_name = 'data/input.json'
required_attributes = JsonFileParser.new('data/input_required_attributes.json').parse
rentals = InputParser.new(JsonFileParser.new(file_name), DataValidator.new(required_attributes)).parse

booking_info = {}
booking_info['rentals'] = []

rentals.each do |rental|
  rental.book
  booking_info['rentals'] << rental.payment_details
end

File.open('data/output.json', 'w') do |f|
  f.write(booking_info.to_json)
end
