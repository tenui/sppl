Factory.define :game do |game|
  game.ordinal 1
end

Factory.define :another_game, :parent => :game do |game|
  game.ordinal 1
end
