# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = ["Action", "Sport", "RPG", "FPS", "MMO-RPG", "Indivierl"]

if Category.count == 0
  categories.each do |c|
    Category.create(name: c)
    puts "created category #{c}"
  end
end

platforms = ["PC Game", "Xbox", "PS4", "PS5", "Nintendo Switch"]

if Platform.count == 0
  platforms.each do |p|
    Platform.create(name: p)
    puts "created platform #{p}"
  end
end

features = ["Action", "Sport", "RPG", "FPS", "MMO-RPG", "Indivierl", "double player"]

if Feature.count == 0
  features.each do |f|
    Feature.create(name: f)
    puts "created feature #{f}"
  end
end