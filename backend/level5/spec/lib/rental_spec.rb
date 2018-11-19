# frozen_string_literal: true

describe Rental do
  describe '#book' do
    context 'given details specific to a particular rental' do
      it 'calculates and updates the applicable price for that rental' do
        rental = setup_data

        rental.book

        expect(rental.allocated_payments).to eq(allocated_payments)
      end
    end
  end

  describe '#payment_details' do
    context 'given a rental with related details' do
      it 'retrieves the payment details to be paid to each stakeholder associated with the rental' do
        rental = setup_data

        rental.book

        expect(rental.payment_details).to eq(
          id: 2,
          options: names_of_additional_features,
          actions: allocated_payments
        )
      end
    end
  end

  private

    def setup_data
      car = Car.new(1, 2000, 10)
      rental = { 'id' => 2, 'car_id' => 1, 'start_date' => '2015-03-31', 'end_date' => '2015-04-01', 'distance' => 300 }
      additional_features = setup_additional_features
      rental = Rental.new(rental, car, additional_features)
    end

    def allocated_payments
      [
        {
          "who": 'driver',
          "type": 'debit',
          "amount": 10_200
        },
        {
          "who": 'owner',
          "type": 'credit',
          "amount": 6160
        },
        {
          "who": 'insurance',
          "type": 'credit',
          "amount": 1020
        },
        {
          "who": 'assistance',
          "type": 'credit',
          "amount": 200
        },
        {
          "who": 'drivy',
          "type": 'credit',
          "amount": 2820
        }
      ]
    end

    def setup_additional_features
      options = [{ 'id' => 1, 'rental_id' => 2, 'type' => 'gps' }, { 'id' => 2, 'rental_id' => 2, 'type' => 'baby_seat' }, { 'id' => 3, 'rental_id' => 2, 'type' => 'additional_insurance' }]

      options.map do |option|
        AdditionalFeature.new(option['id'], option['rental_id'], option['type'])
      end
    end

    def names_of_additional_features
      %w[gps baby_seat additional_insurance]
    end
end
