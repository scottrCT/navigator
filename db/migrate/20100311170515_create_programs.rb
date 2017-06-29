class CreatePrograms < ActiveRecord::Migration
  def self.up
    create_table :programs do |t|
      t.string :name
      t.text :description
      t.float :fpl_max
      t.float :smi_max
      t.float :annual_income_max
      t.string :method_nm

      t.timestamps
    end
  end

  def self.down
    drop_table :programs
  end
end
