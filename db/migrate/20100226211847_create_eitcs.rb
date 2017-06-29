class CreateEitcs < ActiveRecord::Migration
  def self.up
    create_table :eitcs do |t|
      t.integer :year
      t.integer :filing_status
      t.integer :children_no
      t.integer :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :eitcs
  end
end
