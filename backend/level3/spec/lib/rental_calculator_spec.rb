# frozen_string_literal: true

describe RentalCalculator do
  describe '#calculate' do
    context 'given vehicle pricing info and travel info related to number of days and distance' do
      it 'calculates total rental amount related to the travel' do
        vehicle_pricing_info = { price_per_day: 2000,
                                 price_per_km: 10 }
        rental_calculator = RentalCalculator.new(vehicle_pricing_info, 12, 1000)

        rental_amount = rental_calculator.calculate_travel_cost

        expect(rental_amount).to eq(27_800)
      end
    end
  end
end
