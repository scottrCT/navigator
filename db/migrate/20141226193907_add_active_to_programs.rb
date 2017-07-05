class AddActiveToPrograms < ActiveRecord::Migration
  def self.up
    add_column :programs, :active, :boolean
  end

  def self.down
    remove_column :programs, :active
  end
end
