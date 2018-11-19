# frozen_string_literal: true

describe InputParser do
  describe '#parse' do
    context 'given a file parser and a data validator' do
      it 'creates different entity related objects & returns rentals related information' do
        file_name = 'data/input.json'
        required_attributes = JsonFileParser.new('data/input_required_attributes.json').parse
        rentals = InputParser.new(JsonFileParser.new(file_name), DataValidator.new(required_attributes)).parse

        expect(rentals.count).to eq(3)
      end
    end
  end
end
