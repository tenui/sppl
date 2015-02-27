class SeasonsController < InheritedResources::Base
  actions :create, :destroy, :edit, :index, :new, :show, :update
  before_filter :require_user

  def new_match
    @season = Season.find(params[:id])
    @match = @season.matches.build
  end

end
