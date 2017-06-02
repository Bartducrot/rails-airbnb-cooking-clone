class ChangeDurationInRecipes < ActiveRecord::Migration[5.1]
  def change
    change_column :recipes, :cooking_time, :string
  end
end
