# frozen_string_literal: true

describe PaymentAllocator do
  describe '#allocate' do
    context 'given total rental amount and commission to be paid out to different actors' do
      it 'allocates the payment to be paid by/to all actors associated with the rental' do
        commissions = {
          insurance_fee: 1020,
          assistance_fee: 200,
          drivy_fee: 820
        }
        price = 6800

        additional_features_cost = [{ actor: 'owner', actor_fee: 500.0 }, { actor: 'owner', actor_fee: 200.0 }, { actor: 'drivy', actor_fee: 1000.0 }]

        payment_allocator = PaymentAllocator.new(price, commissions, additional_features_cost)

        expect(payment_allocator.allocate).to eq(allocated_payments)
      end
    end
  end

  private

    def allocated_payments
      [
        {
          "who": 'driver',
          "type": 'debit',
          "amount": 8500
        },
        {
          "who": 'owner',
          "type": 'credit',
          "amount": 5460
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
          "amount": 1820
        }
      ]
    end
end
