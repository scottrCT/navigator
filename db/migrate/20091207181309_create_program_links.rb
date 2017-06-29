class CreateProgramLinks < ActiveRecord::Migration
  def self.up
    create_table :program_links do |t|
      t.integer :program_id
      t.string :name
      t.string :link

      t.timestamps
    end
  end

  def self.down
    drop_table :program_links
  end
end
