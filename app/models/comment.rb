class Comment < ActiveRecord::Base
    validates_numericality_of :zip, 
                              :allow_nil => true,
                              :if => Proc.new {|c| !c.zip.blank?}  
end
