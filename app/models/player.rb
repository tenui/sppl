class Player < ActiveRecord::Base

  has_many :results, :dependent => :restrict
  has_many :games, :through => :results, :order => "place"

  scope :active, where(1 == 1)
  
  def <=>(another_player)
    self.total_points <=> another_player.total_points
  end

  def self.sorted_by_first_name
    order('first_name, last_name')
  end
  
  def full_name
    return "#{self.first_name} #{self.last_name}"
  end

  def non_scoring_results(season_id)
    self.season_results(season_id) - self.scoring_results(season_id)
  end

  def scoring_results(season_id)
    ary = self.season_results(season_id).sort {|x, y| y.points <=> x.points}
    ary[0..5]
  end

  def season_games(season_id)
    self.season_results(season_id).collect {|result| result.game}
  end

  def season_results(season_id)
    self.results.select {|result| result.game.match.season_id == season_id}
  end

  def season_total_points(season_id)
    return 0 if self.season_results(season_id).nil? 
    p = self.scoring_results(season_id).inject(0) {|sum, each| sum + each.points}
    p.round(2)
  end

  def to_s
    full_name
  end

  def total_points
    self.season_total_points(Season.find(:last).id)
  end

end
