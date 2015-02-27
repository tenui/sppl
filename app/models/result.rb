class Result < ActiveRecord::Base

  acts_as_list :scope => :game, :column => "place"

  belongs_to :game
  belongs_to :player

  def points
    # 10*(SQRT(A2)/SQRT(1))*(1+LOG(10+0.25))
    return (10 * (Math.sqrt(self.game.players.count)/Math.sqrt(self.place)) * (1 + Math.log10(10 + 0.25))).round(2)
  end

end
