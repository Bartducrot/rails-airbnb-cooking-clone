# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def transform_time(t)
  match_data = t.match(/((?<h>\d{0,2}) hours? and (?<m>\d{1,2}) mins)|((?<j>\d{0,2}) hours?)|((?<n>\d{1,2}) mins)/)
  match_data[:h].to_i * 60 + match_data[:m].to_i + match_data[:j].to_i * 60 + match_data[:n].to_i
end


Transaction.destroy_all
User.destroy_all
Recipe.destroy_all

admin = User.create(first_name: "administration", email: "hubert@gmail.com", password: "123456")
1.times do |i|
    ingredients = ["sushi", "french", "italian"]
    base_url = "https://www.bbcgoodfood.com"
    ingredients.each do |ingredient|
      url = "https://www.bbcgoodfood.com/search/recipes?query=#{ingredient}#query=#{ingredient}&page=#{i}"
      html = Nokogiri::HTML(open(url))

      html.search('.node-recipe').each do |node|
        title = node.search('h3 a').text.strip
        cooking_time = node.search('.teaser-item__info-item--total-time').text.strip
        cooking_time = transform_time(cooking_time)

        difficulty = node.search('.teaser-item__info-item--skill-level').text.strip
        description = node.search('.field-items > .field-item').text.strip

        show = base_url + node.search('a').attr('href').text.strip
        show_html = Nokogiri::HTML(open(show))
        photo_max = show_html.search(".img-container img").attr('src').text.strip
        instructions = show_html.search('.method__list p').text.strip

        recipe = Recipe.new()
        recipe.title = title
        recipe.cooking_time = cooking_time
        recipe.difficulty = difficulty
        recipe.description = description
        recipe.instructions = instructions
        recipe.remote_photo_url = "https:" + photo_max if photo_max
        recipe.user = admin
        recipe.save!
        puts "hacked recipe #{recipe.title}"
      end
    end
end
