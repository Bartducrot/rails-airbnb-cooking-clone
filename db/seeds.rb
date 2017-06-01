# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Recipe.destroy_all

bob = User.create(email: "bob@gmail.com", password: "123123")

ingredients = ["salmon", "chocolate", "vanilla", "pasta"]

ingredients.each do |ingredient|
  url = "https://www.bbcgoodfood.com/search/recipes?query=#{ingredient}"
  html = Nokogiri::HTML(open(url))

  html.search('.node-recipe').each do |node|
    title = node.search('h3 a').text.strip
    cooking_time = node.search('.teaser-item__info-item--total-time').text.strip
    difficulty = node.search('.teaser-item__info-item--skill-level').text.strip
    description = node.search('.field-items > .field-item').text.strip
    photo = node.search('.teaser-item__image img').text.strip

    recipe = Recipe.new()
    recipe.title = title
    recipe.cooking_time = cooking_time
    recipe.difficulty = difficulty
    recipe.description = description
    recipe.photo = photo
    recipe.user = bob
    recipe.save!
  end
end
