# frozen_string_literal: true

describe AdditionalFeaturesCalculator do
  describe '#calculate' do
    context 'given a collection of additional features and the number of days of travel' do
      it 'calculates the cost related to each feature based on the number of days of travel' do
        additional_features = setup_additional_features
        number_of_days_of_travel = 3
        additional_features_calculator = AdditionalFeaturesCalculator.new(additional_features, number_of_days_of_travel)
        feature_cost_details = {
          'beneficiary' => 'owner',
          'price_per_day' => 500
        }
        feature_cost_details2 = {
          'beneficiary' => 'owner',
          'price_per_day' => 200
        }

        allow(additional_features.first).to receive(:cost_details).and_return(feature_cost_details)
        allow(additional_features.last).to receive(:cost_details).and_return(feature_cost_details2)

        expect(additional_features_calculator.calculate).to eq([{ actor: 'owner', actor_fee: 1500.0 },
                                                                { actor: 'owner', actor_fee: 600.0 }])
      end
    end
  end
end

private

def setup_additional_features
  options = [{ 'id' => 1, 'rental_id' => 2, 'type' => 'gps' }, { 'id' => 2, 'rental_id' => 2, 'type' => 'baby_seat' }]

  options.map do |option|
    AdditionalFeature.new(option['id'], option['rental_id'], option['type'])
  end
end
