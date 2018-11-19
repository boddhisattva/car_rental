# frozen_string_literal: true
require_relative 'actor'

class PaymentAllocator
  DRIVER_PAYMENT_TYPE = 'debit'
  DRIVER_ACTOR = 'driver'
  OWNER_ACTOR = 'owner'

  def initialize(price, commission, additional_features_cost)
    @price = price
    @commission = commission
    @additional_features_cost = additional_features_cost
    @actors = all_actors
  end

  def allocate
    actors.map(&:details)
  end

  private

    attr_reader :price, :commission, :actors, :additional_features_cost

    def all_actors
      fixed_actors + other_actors
    end

    def fixed_actors
      [Actor.new(DRIVER_ACTOR, price + additional_features_cost_to_be_paid_by_driver, DRIVER_PAYMENT_TYPE),
       Actor.new(OWNER_ACTOR, amount_to_pay_owner(price))]
    end

    def other_actors
      commission.map do |actor, amount_to_be_paid_to_actor|
        actual_actor = extract_actor_name(actor)
        Actor.new(actual_actor, amount_to_be_paid_to_actor + additional_features_amount_to_be_paid(actual_actor))
      end
    end

    def amount_to_pay_owner(price)
      additional_features_amount_to_pay_owner = additional_features_cost_to_pay_owner

      price - total_commission + round_if_no_decimals(additional_features_amount_to_pay_owner)
    end

    def total_commission
      commission.values.inject(:+)
    end

    def additional_features_cost_to_pay_owner
      return 0 if additional_features_cost.empty?

      owner_related_additional_features = additional_features_cost.select { |collection| collection[:actor] == 'owner' }
      calculate_total_additional_features_cost(owner_related_additional_features)
    end

    def additional_features_cost_to_be_paid_by_driver
      return 0 if additional_features_cost.empty?

      round_if_no_decimals(calculate_total_additional_features_cost(additional_features_cost))
    end

    def extract_actor_name(actor)
      actor.to_s.split('_')[0]
    end

    def additional_features_amount_to_be_paid(actor)
      if additional_features_cost.empty? ||
         (actor_related_additional_features = additional_features_cost.select { |collection| collection[:actor] == actor }).empty?
        0
      else
        round_if_no_decimals(calculate_total_additional_features_cost(actor_related_additional_features))
      end
    end

    def calculate_total_additional_features_cost(actor_related_additional_features)
      actor_related_additional_features.map { |collection| collection.slice(:actor_fee).values }.flatten.sum
    end

    def round_if_no_decimals(amount)
      amount % 1 == 0 ? amount.to_i : amount
    end
end
