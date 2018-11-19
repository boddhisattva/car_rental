# frozen_string_literal: true

describe DataValidator do
  describe '#validate' do
    context 'given a set of required attributes, an entity record and an entity name' do
      let(:required_attributes) { JsonFileParser.new('data/input_required_attributes.json').parse }
      let(:data_validator) { DataValidator.new(required_attributes) }

      context 'required attributes are not present' do
        it 'raises an invalid record error and returns an appropriate error message' do
          rental_record = { 'id' => 1, 'car_id' => 1, 'start_date' => '2015-12-8', 'distance' => 100 }
          entity_name = 'rentals'

          expect { data_validator.validate(rental_record, entity_name) }.to raise_error(
            InvalidRecordError, 'end_date attribute related key value pair is missing for rentals entity in the given input file'
          )
        end
      end

      context 'required attributes do not have corresponding values' do
        it 'raises an invalid record error and returns an appropriate error message' do
          additional_features_record = { 'id' => 1, 'rental_id' => '', 'type' => '' }
          entity_name = 'options'

          expect { data_validator.validate(additional_features_record, entity_name) }.to raise_error(
            InvalidRecordError, "The value is not present for the 'rental_id' key in the given input file with regard to the options entity, " \
                                "The value is not present for the 'type' key in the given input file with regard to the options entity"
          )
        end
      end
    end
  end
end
