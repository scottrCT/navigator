class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :visit_frequency
      t.string :survey_for
      t.string :specific_info
      t.string :ease_of_use
      t.string :useful
      t.string :overall
      t.text :comments
      t.string :zip
      t.string :ip_addr

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
