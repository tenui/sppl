class LinkMatchesToSeasons < ActiveRecord::Migration
  def self.up
    add_column :matches, :season_id, :integer
  end

  def self.down
    remove_column :matches, :season_id
  end
end
