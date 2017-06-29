class CreateResidencies < ActiveRecord::Migration
  def self.up
    create_table :residencies do |t|
      t.text :status

      t.timestamps
    end
  end

  def self.down
    drop_table :residencies
  end
end
