class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id

  # validation
  validates :user_id, :content, :presence => true

  # association
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
end
