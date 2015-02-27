Factory.define :user do |user|
  user.username "poker"
  user.password "password"
  user.password_confirmation "password"
end

Factory.define :admin, :parent => :user do |user|
  user.username "admin"
  user.password "password"
  user.password_confirmation "password"
end

