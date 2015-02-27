class MatchesController < InheritedResources::Base

  actions :create, :destroy, :edit, :new, :show, :update
  before_filter :require_user

  def index
    @season = (params[:season_id].nil?) ? Season.find(:last) : Season.find(params["season_id"])
    @matches = @season.matches
  end

  def new_game
    @match = Match.find(params[:id])
    @game = @match.games.build
    @players = Player.all.sort {|a, b| a.full_name <=> b.full_name}
  end

end
