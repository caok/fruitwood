class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.float :price
      t.references :category
      t.text :cover
      t.text :content

      t.timestamps
    end
    add_index :dishes, :category_id
  end
end
