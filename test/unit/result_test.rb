require 'test_helper'

class ResultTest < ActiveSupport::TestCase

  setup do
    @game = Factory(:game)

    @gus = Factory(:player)
    @dan = Factory(:player_2)
  end

  should belong_to      :game
  should belong_to      :player

  should have_db_column :place
  should have_db_column :created_at
  should have_db_column :updated_at

  should "initially sort Players in a Game based upon their order of addition" do
    @game.players << @gus
    @game.players << @dan
    @game.save
    assert_equal @gus, @game.players.first
  end

  context "when altering the sort order" do
    setup do
      @gp1 = Result.create :game => @game, :player => @dan, :place => 1 
      @gp2 = Result.create :game => @game, :player => @gus, :place => 2 
    end

    should "be able to change the Place by direct editing" do
      assert_equal @dan, @game.players.first
      
      @gp1.place = 2
      @gp1.save

      @gp2.place = 1
      @gp2.save

      assert_equal @gus.id, @game.players.first.id
    end

    should "be able to alter the sort order by using the acts_as_list methods" do
      assert_equal @dan, @game.players.first

      @game.results.first.move_to_bottom    
      assert_equal @gus.id, @game.players.first.id

      @game.results.last.move_higher
      assert_equal @dan.id, @game.players.first.id
    end
  end

  should "be able to calculate the points for each Game Player" do
    @gp1 = Result.create :game => @game, :player => @dan, :place => 1 
    @gp2 = Result.create :game => @game, :player => @gus, :place => 2 
    assert_equal 28.44, @gp1.points
    assert_equal 20.11, @gp2.points
  end

end
