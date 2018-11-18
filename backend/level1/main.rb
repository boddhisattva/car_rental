require_relative 'lib/file_parser'

file_name = "data/input.json"
rentals = FileParser.new(file_name).parse

booking_info = {}
booking_info["rentals"] = []

rentals.each do |rental|
  rental.book
  booking_info["rentals"] << rental.booking_details
end

File.open("data/output.json", "w") do |f|
  f.write(booking_info.to_json)
end