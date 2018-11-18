# frozen_string_literal: true

describe Car do
  describe '#booking_rate' do
    context 'given a car with related pricing details' do
      it 'returns the price per day and per km' do
        car = Car.new(1, 2000, 10)

        expect(car.booking_rate).to eq(
          price_per_day: 2000,
          price_per_km: 10
        )
      end
    end
  end
end
