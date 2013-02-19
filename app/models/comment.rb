class Comment < ActiveRecord::Base
  attr_accessible :attach_id, :attach_type, :content, :user_id, :attach

  belongs_to :user
  belongs_to :attach, :polymorphic => true

  validates :attach, :user, :content, :presence => true
end
