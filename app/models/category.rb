class Category < ActiveRecord::Base
  attr_accessible :name

  # validation
  validates :name, :presence => true, :uniqueness => true

  # association
  has_many :dishes
end
