class AddSurveyToLinkTracker < ActiveRecord::Migration
  def self.up
    add_column :link_trackers, :survey, :integer
  end

  def self.down
    remove_column :link_trackers, :survey
  end
end
