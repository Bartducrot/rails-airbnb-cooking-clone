class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.integer :cooking_time
      t.string :difficulty
      t.integer :price
      t.string :cuisine_type
      t.string :title
      t.text :description
      t.text :instructions
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
