class UsersController < ApplicationController
  load_and_authorize_resource :only => [:show, :index, :set_roles, :update_roles]

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

  def set_roles
    @user = User.find(params[:id])
  end

  def update_roles
    @user = User.find(params[:id])

    # check permition
    authorize! :assign_roles, @user if params[:user][:roles]

    @user.roles = params[:user][:roles]

    respond_to do |format|
      if @user.save
        format.html {redirect_to users_url, :notice => I18n.t("flash.users.authorization_success.notice")}
      else
        format.html {render :action => set_roles}
      end
    end
  end
end
