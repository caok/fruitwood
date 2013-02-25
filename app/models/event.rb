class Event < ActiveRecord::Base
  extend HasHtmlPipeline
  has_html_pipeline :content, :markdown

  attr_accessible :content, :end_date, :start_date, :title

  ##############
  # validation #
  ##############
  validates :title, :start_date, :end_date, :presence => true
  validate :end_date_must_after_start_date

  # association
  has_many :comments, :as => :commentable, :dependent => :destroy

  # scope
  scope :unfinished, where(["end_date > ? ", Date.current])

  private
  def end_date_must_after_start_date
    if end_date.present? && start_date.present? && end_date < start_date
      message = I18n.t('errors.messages.greater_than_or_equal_to', :count => Event.human_attribute_name(:start_date))
      errors.add(:end_date, message)
    end
  end
end
