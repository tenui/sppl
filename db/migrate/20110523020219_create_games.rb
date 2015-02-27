class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :match_id
      t.integer :ordinal
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
