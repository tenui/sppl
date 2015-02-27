class LinkPlayersAndGames < ActiveRecord::Migration
  def self.up
    create_table :game_players do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :place
      t.timestamps
    end
    add_index "game_players", ["game_id", "player_id"], :name => "ak_game_players"
  end

  def self.down
    drop_table :game_players
  end
end
