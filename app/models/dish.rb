class Dish < ActiveRecord::Base
  attr_accessible :content, :cover, :name, :price

  validates :name, :cover, :price, :category, :presence => true

  belongs_to :category

  has_html_pipeline :cover, :markdown
  has_html_pipeline :content, :markdown
end
