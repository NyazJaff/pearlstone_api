class CreateCalculationResults < ActiveRecord::Migration[6.0]
  def change
    create_table :calculation_results do |t|
      t.decimal :average_kws,              :precision => 10, :scale => 2
      t.decimal :turn_off, :precision => 10, :scale => 2
      t.decimal :events_per_week, :precision => 10, :scale => 2
      t.decimal :events_duration, :precision => 10, :scale => 2
      t.decimal :annual_duos_shares, :precision => 10, :scale => 2
      t.decimal :annual_triad_share, :precision => 10, :scale => 2
      t.decimal :annual_energy_share, :precision => 10, :scale => 2
      t.decimal :annual_customer_revenue, :precision => 10, :scale => 2
      t.decimal :total_annual_benefit, :precision => 10, :scale => 2
      t.decimal :carbon_emission_reduction, :precision => 10, :scale => 2
      t.decimal :annual_reduction_in_miles_driven, :precision => 10, :scale => 2
      t.integer :user_id
      t.timestamps
    end

    add_index(:calculation_results, [:user_id])
  end
end
