class Dish < ActiveRecord::Base
  belongs_to :category
  attr_accessible :content, :cover, :name, :price
end
