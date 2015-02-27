require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  
  setup do
    @season = Factory(:season)
    @m = Factory(:match, :season => @season)
    @g = Factory(:game, :match => @m)
    @player = Factory(:player)
    @player.games << @g 
    @player.save
    sign_in_as_player
  end
  
  context "When showing ALL the Players in HTML" do
    setup do
      get :index
    end
  
    should "use the index template" do
      assert_response :success
      assert_template :index
    end

    should "have a Players collection representing all the Players" do
      assert_not_nil assigns(:players)
    end

    should "display the Player's full name" do
      assert_select "table tr td", @player.full_name
    end

    should "link the Player's full name to the Show action" do
      assert_tag :tag => "a", :content => "#{@player.full_name}", :attributes => {:href => player_path(@player.id)}
    end

    should "Use Player Total Points as a Header" do
      assert_select "table tr th", "Total Points"
    end

    should "Properly display the Player's Total Points" do
      assert_select "table tr td", "#{@player.total_points}"
    end
    
    should "NOT show the Actions column and links" do
      assert_no_tag :tag => "a", :content => "Change", :attributes => {:href => edit_player_path(@player.id)}
      assert_no_tag :tag => "a", :content => "Remove"
    end

    should "NOT show the link to add a new Player" do
      assert_no_tag :tag => "a", :content => "Add a New Player", :attributes => {:href => new_player_path}
    end

  end

  context "AND logged in as Admin" do
    setup do
      sign_in_as_admin
      get :index
    end

    should "show the link to add a new Player" do
      assert_tag :tag => "a", :content => "Add a New Player", :attributes => {:href => new_player_path}
    end
    
    should "show the Actions column and links" do
      assert_tag :tag => "a", :content => "Change", :attributes => {:href => edit_player_path(@player.id)}
      assert_tag :tag => "a", :content => "Remove"
    end

  end

  # -------------------------------------------------------------------
  # Show
  # -------------------------------------------------------------------
  context "When showing a single Player" do
    setup do
      get :show, :id => @player.to_param
      assert_response :success
    end

    should "use the show template" do
      assert_template :show
    end

    should "Correctly display the Header" do
      assert_select "h3", "Showing a Player"
    end

    should "Have a Details and a Games Played sections" do
      assert_select "h4", "Details"
      assert_select "h4", "Games Played"
    end

    should "display a link back to the associated Games the Player has played" do
      get :show, :id => @player.id
      assert_select "td a[href=?]", "/games/#{@g.id}"#, :text => @g.to_s
    end
  end

  should "Display 'None' in italic if the players has not played any Games" do
    @player2 = Factory(:player_2)
    get :show, :id => @player2.to_param
    assert_select "i", "None"
  end

  # -------------------------------------------------------------------
  # New
  # -------------------------------------------------------------------
  context "When showing the form to create a New Player" do
    setup do
      get :new
    end

    should "be displayed using the new template" do
      assert_response :success
    end
    
    should "Correctly display the Header" do
      assert_select "h1", "Creating a Player"
    end

    should "Display the Player's Id" do
      assert_select "table tr th", "Player #"
    end

    should "Show that we can enter the First Name" do
      assert_select "table tr th", "First name"
    end

  end

  context "When creating a Player" do
    should "be able to create a Player" do
      assert_difference('Player.count') do
        post :create, :player => @player.attributes
      end
      assert_redirected_to player_path(assigns(:player))
    end
  end

  context "When editing a Player" do
    setup do
      get :edit, :id => @player.to_param
    end

    should "display the edit form" do
      assert_response :success
    end

    should "use the edit template" do
      assert_template :edit
    end

    should "redirect to the show view after a successful edit" do
      put :update, :id => @player.to_param, :player => @player.attributes
      assert_redirected_to player_path(assigns(:player))
    end
  end

# TODO: Provide better tests that show you CAN delete a Player, but only
# if they have no Results
  
#  context "When removing a Player" do
#    should "be able to destroy a Player" do
#      assert_difference('Player.count', -1) do
#        delete :destroy, :id => @player.to_param
#      end
#    end
#
#    should "be redirected back to the display of all Players" do
#      delete :destroy, :id => @player.to_param
#      assert_redirected_to players_path
#    end
#  end

end
