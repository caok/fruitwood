class Dish < ActiveRecord::Base
  extend HasHtmlPipeline
  attr_accessible :content, :cover, :name, :price, :category_id

  validates :name, :cover, :price, :category, :presence => true

  belongs_to :category

  has_html_pipeline :cover, :markdown
  has_html_pipeline :content, :markdown
end
