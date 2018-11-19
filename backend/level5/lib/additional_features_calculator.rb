# frozen_string_literal: true

class AdditionalFeaturesCalculator
  def initialize(additional_features, number_of_days_of_travel)
    @additional_features = additional_features
    @number_of_days_of_travel = number_of_days_of_travel
  end

  def calculate
    additional_features.map do |feature|
      feature_cost_details = feature.cost_details
      cost = compute_cost(feature_cost_details)
      { actor: feature_cost_details['beneficiary'], actor_fee: cost }
    end
  end

  private

    attr_reader :additional_features, :number_of_days_of_travel

    def compute_cost(feature_cost_details)
      number_of_days_of_travel * feature_cost_details['price_per_day']
    end
end
