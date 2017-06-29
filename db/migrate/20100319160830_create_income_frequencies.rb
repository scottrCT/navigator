class CreateIncomeFrequencies < ActiveRecord::Migration
  def self.up
    create_table :income_frequencies do |t|
      t.string :frequency
      t.integer :annual_multiplier

      t.timestamps
    end
  end

  def self.down
    drop_table :income_frequencies
  end
end
