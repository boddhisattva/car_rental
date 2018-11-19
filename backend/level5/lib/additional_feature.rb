# frozen_string_literal: true

require 'bigdecimal'

class AdditionalFeature
  PRICING_WITH_DAY_INFO = {
    'gps' => { 500 => 1 },
    'baby_seat' => { 200 => 1 },
    'additional_insurance' => { 1000 => 1 }
  }.freeze

  BENEFICIARY = {
    'gps' => 'owner',
    'baby_seat' => 'owner',
    'additional_insurance' => 'drivy'
  }.freeze

  attr_reader :name, :rental_id

  def initialize(id, rental_id, name)
    @id = id
    @rental_id = rental_id
    @name = name
    @beneficiary = BENEFICIARY.fetch(name)
  end

  def cost_details
    {
      'beneficiary' => beneficiary,
      'price_per_day' => calculate_per_day_cost(name)
    }
  end

  private

    attr_reader :beneficiary

    def calculate_per_day_cost(name)
      @price_per_day ||= compute_cost(name)
    end

    def compute_cost(name)
      cost_info = PRICING_WITH_DAY_INFO.fetch(name)

      price = cost_info.keys.first
      number_of_days = cost_info.values.first

      price / BigDecimal.new(number_of_days)
    end
end
