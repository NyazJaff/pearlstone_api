class CreateCalculationResults < ActiveRecord::Migration[6.0]
  def change
    create_table :calculation_results do |t|
      t.decimal :annual_duos_shares
      t.decimal :annual_triad_share
      t.decimal :annual_energy_share
      t.decimal :total_annual_benefit
      t.decimal :carbon_emission_reduction
      t.decimal :annual_reduction_in_miles_driven
      t.integer :user_id
      t.timestamps
    end

    add_index(:calculation_results, [:user_id])
  end
end
