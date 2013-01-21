class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @search = User.search(params[:q])
    @users= @search.result
    @users = @users.page(params[:page])

    respond_to do |format|
      format.html
    end
  end
end
