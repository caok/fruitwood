module CommentHelper
  def read_comments?(comments)
    can? :create, Comment or comments.size > 0
  end

  def format_date(datetime)
    if datetime.nil?
      datetime
    else
      datetime.strftime("%Y-%m-%d")
    end
  end
end
