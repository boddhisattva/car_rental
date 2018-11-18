# frozen_string_literal: true

class Actor
  def initialize(name, amount, payment_type = 'credit')
    @name = name
    @amount = amount
    @payment_type = payment_type
  end

  def details
    {
      who: name,
      type: payment_type,
      amount: amount
    }
  end

  private

    attr_reader :name, :amount, :payment_type
end
