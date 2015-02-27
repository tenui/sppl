class Season < ActiveRecord::Base
  has_many :matches

  def name
    return "Season ##{self.ordinal}"
  end

  def to_s
    name
  end

end
