class AddSeasonColumns < ActiveRecord::Migration
  def self.up
    rename_column :seasons, :name, :ordinal
    add_column :seasons, :start_year, :integer
    add_column :seasons, :stop_year, :integer
  end

  def self.down
    rename_column :seasons, :ordinal, :name
    remove_column :seasons, :start_year
    remove_column :seasons, :stop_year
  end
end
