class CreateSmis < ActiveRecord::Migration
  def self.up
    create_table :smis do |t|
      t.integer :year
      t.integer :family_size
      t.float :amt

      t.timestamps
    end
  end

  def self.down
    drop_table :smis
  end
end
