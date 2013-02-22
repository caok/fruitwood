class Dish < ActiveRecord::Base
  extend HasHtmlPipeline
  has_html_pipeline :cover, :markdown
  has_html_pipeline :content, :markdown

  attr_accessible :content, :cover, :name, :price, :category_id

  ##############
  # validation #
  ##############
  validates :name, :cover, :price, :category_id, :presence => true
  validates :name, :uniqueness => true
  validates :price, :numericality => true

  # association
  belongs_to :category
  has_many :comments, :as => :commentable, :dependent => :destroy
end
