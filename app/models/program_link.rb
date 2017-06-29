class ProgramLink < ActiveRecord::Base
  belongs_to :program
  has_many :link_trackers
end
