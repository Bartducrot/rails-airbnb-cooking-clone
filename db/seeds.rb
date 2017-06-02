Transaction.destroy_all
Recipe.destroy_all
User.destroy_all

admin = User.create(first_name: "Hubert", last_name: "OSS 117", email: "hubert@gmail.com", password: "123456")

1.times do |i|
    url = "https://www.bbcgoodfood.com/search/recipes?query=&op=Search#page=#{i}"
    html = Nokogiri::HTML(open(url))

    ingredients = ["french"]
    base_url = "https://www.bbcgoodfood.com"
    ingredients.each do |ingredient|
      url = "https://www.bbcgoodfood.com/search/recipes?query=#{ingredient}#query=#{ingredient}&page=#{i}"
      url = "https://www.bbcgoodfood.com/search/recipes?query=#{ingredient}"
      html = Nokogiri::HTML(open(url))

      html.search('.node-recipe').each do |node|
        title = node.search('h3 a').text.strip
        cooking_time = node.search('.teaser-item__info-item--total-time').text.strip
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
