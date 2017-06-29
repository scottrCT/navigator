class CreateSelectOptions < ActiveRecord::Migration
  def self.up
    create_table :select_options do |t|
      t.string :list_option

      t.timestamps
    end
  end

  def self.down
    drop_table :select_options
  end
end
