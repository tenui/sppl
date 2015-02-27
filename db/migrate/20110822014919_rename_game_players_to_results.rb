class RenameGamePlayersToResults < ActiveRecord::Migration
  def self.up
    rename_table :game_players, :results
  end

  def self.down
    rename_table :results, :game_players
  end
end
