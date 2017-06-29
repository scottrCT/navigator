class CreateLinkTrackers < ActiveRecord::Migration
  def self.up
    create_table :link_trackers do |t|
      t.string :ip_addr
      t.integer :link

      t.timestamps
    end
  end

  def self.down
    drop_table :link_trackers
  end
end
