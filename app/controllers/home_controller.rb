class HomeController < ApplicationController
  def index
    @user = current_user
    @events = Event.unfinished.order("start_date")
    @dishes = Dish.first(4)
  end

  def content_preview
    render :nothing => true, :status => 200,
           :json => {:result => ContentFilter.refine(params[:content]) }
  end
end
