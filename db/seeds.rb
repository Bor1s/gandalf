# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

['Dungeons & Dragons Next', 'GURPS', 'HeroQuest II', 'Pathfinder', 'D20 Modern', 'Fate'].each do |name|
  GameSystem.create(name: name) unless GameSystem.where(name: name).exists?
end
