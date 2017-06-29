class CreateFpls < ActiveRecord::Migration
  def self.up
    create_table :fpls do |t|
      t.integer :year
      t.integer :base_amt
      t.integer :offset

      t.timestamps
    end
  end

  def self.down
    drop_table :fpls
  end
end
