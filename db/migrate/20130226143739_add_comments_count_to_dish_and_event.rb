class AddCommentsCountToDishAndEvent < ActiveRecord::Migration
  def self.up
    add_column :dishes, :comments_count, :integer, :default => 0
    add_column :events, :comments_count, :integer, :default => 0

    Dish.find_each do |dish|
      dish.update_attribute(:comments_count, dish.comments.size)
    end

    Event.find_each do |event|
      event.update_attribute(:comments_count, event.comments.size)
    end
  end

  def self.down
    remove_column :dishes, :comments_count
    remove_column :events, :comments_count
  end
end
