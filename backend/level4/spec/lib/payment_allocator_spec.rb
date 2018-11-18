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

        payment_allocator = PaymentAllocator.new(price, commissions)

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
          "amount": 6800
        },
        {
          "who": 'owner',
          "type": 'credit',
          "amount": 4760
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
          "amount": 820
        }
      ]
    end
end
