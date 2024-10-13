# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
end

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.name = "James"
  user.password = "password"
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.password = "password"
end

Post.find_or_create_by!(title: "10/10(木)") do |post|
  post.text = "seedのお試し。"
  post.user = olivia
end

Post.find_or_create_by!(title: "和食屋せん") do |post|
  post.text = "日本料理は美しい！"
  post.user = james
end

Post.find_or_create_by!(title: "ShoreditchBar") do |post|
  post.text = 'メキシコ料理好きな方にオススメ！'
  post.user = lucas
end