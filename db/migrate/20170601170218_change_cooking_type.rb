class ChangeCookingType < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :cooking_time, :string
    add_column :recipes, :cooking_time, :integer
  end
end
