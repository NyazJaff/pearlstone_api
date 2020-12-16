# frozen_string_literal: true

# == Schema Information
#
# Table name: calculation_results
#
#  id                               :integer          not null, primary key
#  annual_duos_shares               :decimal
#  annual_triad_share               :decimal
#  annual_energy_share              :decimal
#  total_annual_benefit             :decimal
#  carbon_emission_reduction        :decimal
#  annual_reduction_in_miles_driven :decimal
#  user_id                          :integer
#
# Indexes
#
#  index_calculation_results_on_user_id     (user_id)
#
class CalculationResult < ApplicationRecord
  # belongs_to :user

end
