class AddProgramsToSurvey < ActiveRecord::Migration
  def self.up
    add_column :surveys, :programs, :string
  end

  def self.down
    remove_column :surveys, :programs
  end
end
