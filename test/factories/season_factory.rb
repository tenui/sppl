Factory.define :season do |season|
  season.sequence(:ordinal) {|n| n }
  season.start_year 2010
  season.stop_year 2011
end

Factory.define :season2, :class => Season do |season|
  season.sequence(:ordinal) {|n| n }
  season.start_year 2011
  season.stop_year 2012
end
