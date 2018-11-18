# frozen_string_literal: true

class CommissionCalculator
  def initialize(price, number_of_days)
    @price = price
    @number_of_days = number_of_days
  end

  COMMISSION_PERCENTAGE = 0.3
  ROADSIDE_ASSITANCE_COST_PER_DAY_IN_CENTS = 100
  INSURANCE_COST_PERCENTAGE = 0.5

  def calculate
    assistance_fee = calculate_roadside_assistance
    insurance_fee = total_commission * INSURANCE_COST_PERCENTAGE

    {
      insurance_fee: round_if_no_decimals(insurance_fee),
      assistance_fee: round_if_no_decimals(assistance_fee),
      drivy_fee: round_if_no_decimals(total_commission - (insurance_fee + assistance_fee))
    }
  end

  private
    attr_reader :price, :number_of_days

    def calculate_roadside_assistance
      number_of_days * ROADSIDE_ASSITANCE_COST_PER_DAY_IN_CENTS
    end

    def total_commission
      @total_commission ||= price * COMMISSION_PERCENTAGE
    end

    def round_if_no_decimals(amount)
      amount % 1 == 0 ? amount.to_i : amount
    end
end
