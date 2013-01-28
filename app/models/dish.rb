class Dish < ActiveRecord::Base
  extend HasHtmlPipeline
  attr_accessible :content, :cover, :name, :price, :category_id

  validates :name, :cover, :price, :category_id, :presence => true
  validates :name, :uniqueness => true
  validates :price, :numericality => true

  belongs_to :category

  has_html_pipeline :cover, :markdown
  has_html_pipeline :content, :markdown
end
