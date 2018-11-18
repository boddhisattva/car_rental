# frozen_string_literal: true

describe CommissionCalculator do
  describe '#calculate' do
    context 'given the rental price related to a travel' do
      it 'calculates the total commission based on the rental price' do
        commission_calculator = CommissionCalculator.new(6800, 2)

        expect(commission_calculator.calculate).to eq(
          insurance_fee: 1020,
          assistance_fee: 200,
          drivy_fee: 820
        )
      end
    end
  end
end
