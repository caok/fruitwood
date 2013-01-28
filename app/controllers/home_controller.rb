class HomeController < ApplicationController
  def index
    @user = current_user
    @events = Event.unfinished.order("start_date")
    @dishes = Dish.first(4)
  end
end
