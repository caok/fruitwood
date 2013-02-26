module CommentHelper
  def read_comments?(comments)
    can? :create, Comment or comments.size > 0
  end

  def format_datetime(datetime)
    if datetime.nil?
      datetime
    else
      I18n.localize(datetime, :format => :stamp)
    end
  end
end
