require 'test_helper'

class MatchesControllerTest < ActionController::TestCase
  
  setup do
    @match = Factory(:match)
    @season = Factory(:season)
    @match.season_id = @season.id
    @match.save
  end
  
  context "When showing ALL the Matches in HTML" do
    setup do
      get :index
    end
  
    should "use the index template" do
      assert_response :success
      assert_template :index
    end

    should "have a Matches collection representing all the Matches" do
      assert_not_nil assigns(:matches)
    end

    should "provide a link to add a new Match" do
      assert_tag :tag => "a", :content => "Add a New Match", :attributes => {:href => new_match_path}
    end

    should "Correctly display the Header" do
      assert_select "h1", "Showing All Matches"
    end

    should "Use Match Date as Headers" do
      assert_select "table tr th", "Match Date"
    end

    should "Properly display the Match's Name, Start Year, and Stop Year" do
      assert_select "table tr td", "#{@match.match_date}"
    end
  end

  # -------------------------------------------------------------------
  # Show
  # -------------------------------------------------------------------
  context "When showing a single Match" do
    setup do
      @g = Factory(:game)
      @match.games << @g
      get :show, :id => @match.to_param
      assert_response :success
    end

    should "use the show template" do
      assert_template :show
    end
    
    should "display a link back to the associated Season" do
      assert_select "a", @match.season.name
    end

    should "display a link to an Associated Game" do
      assert_select "a", "Game ##{@g.ordinal}" 
    end

# Not exactly sure why this doesn't work???
#    should "display the italic word 'None' if there are no Associated Games" do
#      @match.games.delete_all
#      @match.save
#      get :show, :id => @match.to_param
#      assert_select "ul li i", "None"
#    end
  end

  # -------------------------------------------------------------------
  # New
  # -------------------------------------------------------------------
  context "When showing the form to create a New Match" do
    setup do
      get :new
    end

    should "be displayed using the new template" do
      assert_response :success
    end
    
    should "Correctly display the Header" do
      assert_select "h1", "Creating a New Match"
    end

    should "Show that we can enter Ordinal, Start Year, and Stop Year" do
      assert_select "table tr th", "Match date"
    end

    should "show a dropdown to associate the Match with a Season" do
      assert_select "table tr th", "Season"
      assert_select "table tr td select[id='match_season_id']"
    end
  end

  context "When creating a Match" do
    should "be able to create a Match" do
      assert_difference('Match.count') do
        post :create, :match => @match.attributes
      end
      assert_redirected_to match_path(assigns(:match))
    end
  end

  context "When editing a Match" do
    setup do
      get :edit, :id => @match.to_param
    end

    should "display the edit form" do
      assert_response :success
    end

    should "use the edit template" do
      assert_template :edit
    end

    should "redirect to the show view after a successful edit" do
      put :update, :id => @match.to_param, :match => @match.attributes
      assert_redirected_to match_path(assigns(:match))
    end
  end

  context "When removing a Match" do
    should "be able to destroy a Match" do
      assert_difference('Match.count', -1) do
        delete :destroy, :id => @match.to_param
      end
    end

    should "be redirected back to the display of all Matches" do
      delete :destroy, :id => @match.to_param
      assert_redirected_to matches_path
    end
  end

end
