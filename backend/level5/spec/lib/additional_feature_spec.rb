# frozen_string_literal: true

describe AdditionalFeature do
  describe '#cost_details' do
    context 'number of days related to additional feature cost pricing is non zero' do
      it 'gets details comprising of beneficiary name and computed per day pricing' do
        additional_feature = AdditionalFeature.new(1, 1, 'baby_seat')

        expect(additional_feature.cost_details).to eq(
          'beneficiary' => 'owner',
          'price_per_day' => 200.0
        )
      end
    end
  end
end
