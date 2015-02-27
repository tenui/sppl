require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  setup do
    @season = Factory(:season)
    @match = Factory(:match, :season => @season)
    @gus = Factory(:player)
    @dan = Factory(:player_2)
  end

  should have_db_column :first_name
  should have_db_column :last_name
  should have_db_column :email
  should have_db_column :phone

  should have_many :games

  should "have a full name method which is the concatenated first and last names" do
    assert_respond_to Player.new, :full_name
    assert_equal "#{@gus.first_name} #{@gus.last_name}", @gus.full_name
  end

  should "initially have no Games" do
    assert_equal 0, @gus.games.count
  end
  
  should "display itself as {first_name} {last_name} by default" do
    assert_equal "#{@gus.first_name} #{@gus.last_name}", "#{@gus}"
  end

  should "be able to assign a Game to a Player" do
    g = Factory(:game, :match => @match)
    @gus.games << g
    assert_equal 1, @gus.games.count
  end
  
  should "total point over all Games" do
    g = Factory(:game, :match => @match)
    r1 = Result.create :game => g, :player => @dan, :place => 1 
    r2 = Result.create :game => g, :player => @gus, :place => 2 
    assert_equal 28.44, @dan.season_total_points(@season.id)
    assert_equal 20.11, @gus.season_total_points(@season.id)
  end

  should "sort Players by their total points" do
    g = Factory(:game, :match => @match)
    r1 = Result.create :game => g, :player => @dan, :place => 1 
    r2 = Result.create :game => g, :player => @gus, :place => 2 
    assert @dan <=> @gus
  end

end
