Factory.define :player do |player|
  player.first_name "Gus"
  player.last_name  "Van Zant"
  player.email      "gv@pokerstars.net"
  player.phone      "5555555555"
end

Factory.define :player_2, :parent => :player do |player|
  player.first_name "Dan"
  player.last_name  "Harrington"
  player.email      "dh@pokerstars.net"
  player.phone      "6666666666"
end
