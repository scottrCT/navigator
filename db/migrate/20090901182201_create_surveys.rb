class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.integer :age
      t.integer :residency_id
      t.integer :resident_of_CT
      t.integer :have_a_spouse
      t.integer :children_under_18
      t.integer :adult_dependants
      t.integer :children_under_13
      t.integer :children_under_5
      t.integer :adult_disability
      t.integer :pregnant
      t.integer :currently_employed
      t.integer :spouse_currently_employed
      t.integer :other_income
      t.integer :tax_filing_method_id
      t.integer :approved_training_activity
      t.integer :spouse_approved_training_activity  
      t.decimal :net_income_amt, :precision => 18, :scale => 2
      t.integer  :net_income_frequency
      t.decimal :spouse_net_income_amt, :precision => 18, :scale => 2
      t.integer  :spouse_net_income_frequency
      t.decimal :other_income_amt, :precision => 18, :scale => 2
      t.integer  :other_income_frequency
      t.timestamps
    end
  end

  def self.down
    drop_table :surveys
  end
end
