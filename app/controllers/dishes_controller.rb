class DishesController < ApplicationController
  load_and_authorize_resource :only => [:new,:edit,:create,:update,:destroy]

  def index
    @dishes= Dish.order("id DESC").page(params[:page]).per(12)
    @dishes = @dishes.where(category_id: params[:category_id]) if params[:category_id].present?

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dishes }
    end
  end

  def show
    @dish = Dish.find(params[:id])
    @commentable = @dish
    @comments = @commentable.comments.includes(:user).page(params[:page])
    #params[:page] = @dish.last_page_with_per_page(4) if params[:page].blank?
    #@comments = @comments.page(params[:page]).per(4)
    @comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dish }
    end
  end

  def new
    @dish = Dish.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dish }
    end
  end

  def edit
    @dish = Dish.find(params[:id])
  end

  def create
    @dish = Dish.new(params[:dish])

    respond_to do |format|
      if @dish.save
        format.html { redirect_to @dish, notice: I18n.t("flash.actions.create.notice") }
        format.json { render json: @dish, status: :created, location: @dish }
      else
        format.html { render action: "new" }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @dish = Dish.find(params[:id])

    respond_to do |format|
      if @dish.update_attributes(params[:dish])
        format.html { redirect_to @dish, notice: I18n.t("flash.actions.update.notice") }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @dish = Dish.find(params[:id])
    @dish.destroy

    respond_to do |format|
      format.html { redirect_to dishes_url }
      format.json { head :no_content }
    end
  end
end
