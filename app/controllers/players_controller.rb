class PlayersController < InheritedResources::Base

  actions :create, :destroy, :edit, :new, :show, :update
 
  def index
    @page_title = "All Players"
    self.set_season
    @players = Player.all.sort.reverse
  end

  def move
    if ["move_lower", "move_higher"].include?(params[:method]) and params[:game_player_id] =~ /^\d+$/
      gp = Result.find(params[:game_player_id])
      gp.send(params[:method]) unless gp.nil?
    end
    redirect_to :controller => :games, :action => :show, :id => gp.game.id
  end

  def set_season
    @season = (params[:season_id].nil?) ? Season.find(:last) : Season.find(params["season_id"])
  end

  def show
    self.set_season
    show! { @page_title = "Showing a Player" }
  end

end
