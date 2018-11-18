# frozen_string_literal: true

describe Rental do
  describe '#book' do
    context 'given details specific to a particular rental' do
      it 'calculates and updates the applicable price for that rental' do
        rental = setup_data

        rental.book

        expect(rental.price).to eq(6800)
        expect(rental.commission).to eq(
          assistance_fee: 200,
          insurance_fee: 1020,
          drivy_fee: 820
        )
      end
    end
  end

  describe '#booking_details' do
    context 'given a rental with related details' do
      it 'retrieves the booking details' do
        rental = setup_data

        rental.book

        expect(rental.booking_details).to eq(
          id: 2,
          price: 6800,
          commission: {
            assistance_fee: 200,
            insurance_fee: 1020,
            drivy_fee: 820
          }
        )
      end
    end
  end

  private

    def setup_data
      car = Car.new(1, 2000, 10)
      rental = { 'id' => 2, 'car_id' => 1, 'start_date' => '2015-03-31', 'end_date' => '2015-04-01', 'distance' => 300 }
      rental = Rental.new(rental, car)
    end
end
