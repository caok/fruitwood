class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :content
      t.references :commentable, :polymorphic => true

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
