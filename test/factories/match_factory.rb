Factory.define :match do |match|
  match.match_date "1/1/2011"
end

Factory.define :another_match, :parent => :match do |match|
  match.match_date "2/1/2011"
end
