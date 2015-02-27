require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  
  setup do
    @season = Factory(:season)
    @match = Factory(:match, :season => @season)
    @game = Factory(:game)
    @game.match_id = @match.id
    @game.save
    sign_in_as_admin
  end
  
  # -------------------------------------------------------------------
  # Index
  # -------------------------------------------------------------------
  context "When showing ALL the Games in HTML" do
    setup do
      get :index
    end
  
    should "use the index template" do
      assert_response :success
      assert_template :index
    end

    should "have a Matches collection holding all the Games to be displayed" do
      assert_not_nil assigns(:matches)
    end

    should "provide a link to add a new Game" do
      assert_tag :tag => "a", :content => "Add a New Game", :attributes => {:href => new_game_path}
    end

    should "Use Game # as a Header" do
      assert_select "table tr th", "Game #"
    end

    should "Properly display the Game's Ordinal" do
      assert_select "table tr td", "#{@game.ordinal}"
    end
  end

  # -------------------------------------------------------------------
  # Show
  # -------------------------------------------------------------------
  context "When showing a single Game" do
    setup do
      @p = Factory(:player)
      @game.players << @p
      get :show, :id => @game.to_param
      assert_response :success
    end

    should "use the show template" do
      assert_template :show
    end
    
    should "display a link back to the associated Match" do
      assert_select "a", "#{@game.match.match_date}"
    end
    
    should "display a list of links to all associated Players in the row detail" do
      assert_select "td a", "#{@p}"
    end

    should "display an Actions Section with a link to add a New Player" do
      assert_select "th", "Actions"
      assert_select "td a", "Choose Players"
    end
  end

  context "When showing a single Game without associated Players" do
    should "display the italic word 'None' if there are no Associated Players" do
      get :show, :id => @game.to_param
      assert_select "td i", "None"
    end
  end

  # -------------------------------------------------------------------
  # New
  # -------------------------------------------------------------------
  context "When showing the form to create a New Game" do
    setup do
      get :new
    end

    should "be displayed using the new template" do
      assert_response :success
    end
    
    should "Correctly display the Header" do
      assert_select "h1", "Creating a Game"
    end

    should "Show that we can enter Ordinal" do
      assert_select "table tr th", "Game #"
    end

    should "show a dropdown to associate the Game with a Match" do
      assert_select "table tr th", "Match"
      assert_select "table tr td select[id='game_match_id']"
    end
  end

  context "When creating a Game" do
    should "be able to create a Game" do
      assert_difference('Game.count') do
        post :create, :game => @game.attributes
      end
    end

    should "be redirected to the index page" do
      post :create, :game => @game.attributes
      assert_redirected_to games_path
    end
  end

  # -------------------------------------------------------------------
  # Edit
  # -------------------------------------------------------------------
  context "When editing a Game" do
    setup do
      get :edit, :id => @game.to_param
    end

    should "display the edit form" do
      assert_response :success
    end

    should "use the edit template" do
      assert_template :edit
    end

    should "redirect to the show view after a successful edit" do
      put :update, :id => @game.to_param, :game => @game.attributes
      assert_redirected_to game_path(assigns(:game))
    end
  end

  context "When removing a Game" do
    should "be able to destroy a Game" do
      assert_difference('Game.count', -1) do
        delete :destroy, :id => @game.to_param
      end
    end

    should "be redirected back to the display of all Games" do
      delete :destroy, :id => @game.to_param
      assert_redirected_to games_path
    end
  end

end
