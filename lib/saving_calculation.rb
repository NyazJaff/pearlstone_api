# frozen_string_literal: true

class SavingCalculation

  def initialize(x_average_kws:, y_turn_off:, z_events_per_week:, t_events_duration:)
    @x_average_kws     = x_average_kws.to_f
    @y_turn_off        = y_turn_off.to_f
    @z_events_per_week = z_events_per_week.to_f
    @t_events_duration = t_events_duration.to_f
  end

  def result
      {
        "annual_duos_shares":               annual_duos_shares,
        "annual_triad_share":               annual_triad_share,
        "annual_energy_share":              annual_energy_share,
        "total_annual_benefit":             total_annual_benefit,
        "carbon_emission_reduction":        carbon_emission_reduction,
        "annual_reduction_in_miles_driven": annual_reduction_in_miles_driven
      }
  end

  def save(user_id = '')
    result_data = result.merge(user_id: user_id)
    CalculationResult.create(result_data.slice(*CalculationResult.column_names.map(&:to_sym)))
  end

  def self.find_by_id
  #  Find calculation in database by id of user or calculation_id
  end

  private
    def annual_duos_shares
      (0.5 * @x_average_kws * @y_turn_off * @z_events_per_week * @t_events_duration * 48 * 3.1 * 0.01).round(2)
    end

    def annual_triad_share
      (0.5 * @x_average_kws * @y_turn_off * 55000 * 0.001).round(2)
    end

    def annual_energy_share
      (1 * 9.2 * @x_average_kws * @y_turn_off * @z_events_per_week * @t_events_duration * 48 * 0.01).round(2)
    end

    def total_annual_benefit
      (annual_duos_shares + annual_triad_share + annual_energy_share).round(2)
    end

    def carbon_emission_reduction
      (0.283 * @x_average_kws * @y_turn_off * @z_events_per_week * @t_events_duration * 48).round(2)
    end

    def annual_reduction_in_miles_driven
      # 2.48139 : convertor factor
      (carbon_emission_reduction * 2.48139).round(2)
    end
end
