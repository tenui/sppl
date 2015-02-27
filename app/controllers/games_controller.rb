class GamesController < InheritedResources::Base

  actions :destroy, :show
  before_filter :require_user
 
  def choose_players
    @game = Game.find(params[:id])
    @players = Player.active.sorted_by_first_name
    render :action => :new
  end
  
  def create
    @game = Game.new(params[:game])
    @game.players = Player.find(params[:player_ids]) if params[:player_ids]
    if @game.save
      flash[:notice] = "Game was successfully created!"
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def index
    @page_title = "Showing All Games"
    @season = (params[:season_id].nil?) ? Season.find(:last) : Season.find(params["season_id"])
    @matches = @season.matches
  end

  def new
    @game = Game.new
    @players = Player.active.sorted_by_first_name
  end

  def update
    @game = Game.find(params[:id])
    @game.players = Player.find(params[:player_ids]) if params[:player_ids]
    if @game.update_attributes(params[:game])
      flash[:notice] = "Game was successfully updated!"
      redirect_to :action => :show, :id => @game
    else
      render :action => :edit
    end
  end

end
