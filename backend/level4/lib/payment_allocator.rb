# frozen_string_literal: true

require_relative 'actor'

class PaymentAllocator
  def initialize(price, commission)
    @price = price
    @commission = commission
    @actors = all_actors
  end

  def allocate
    actors.map(&:details)
  end

  private

    attr_reader :price, :commission, :actors

    def all_actors
      fixed_actors + other_actors
    end

    def fixed_actors
      [Actor.new('driver', price, 'debit'),
       Actor.new('owner', amount_to_pay_owner(price))]
    end

    def other_actors
      commission.map do |actor, amount_to_be_paid_to_actor|
        Actor.new(actor.to_s.split('_')[0], amount_to_be_paid_to_actor)
      end
    end

    def amount_to_pay_owner(price)
      price - total_commission
    end

    def total_commission
      commission.values.inject(:+)
    end
end
