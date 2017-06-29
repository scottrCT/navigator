class CreateTaxFilingMethods < ActiveRecord::Migration
  def self.up
    create_table :tax_filing_methods do |t|
      t.text :tax_method

      t.timestamps
    end
  end

  def self.down
    drop_table :tax_filing_methods
  end
end
