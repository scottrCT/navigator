class AddIpAddrToSurveys < ActiveRecord::Migration
  def self.up
    add_column :surveys, :ip_addr, :string
  end

  def self.down
    remove_column :surveys, :ip_addr
  end
end
