class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.text :content
      t.integer :attach_id
      t.string :attach_type

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :attach_id
  end
end
