class GamesController < InheritedResources::Base
  actions :destroy, :index, :show
  
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
    @players = Player.all
  end

  def new
    @game = Game.new
    @players = Player.all
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
