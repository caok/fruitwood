class CommentsController < ApplicationController
  load_and_authorize_resource :only => [:create, :destroy]
  before_filter :load_commentable

  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment])

    respond_to do |format|
      if @comment.save
        #redirect_to @commentable, :notice => "Comment created."
        format.html { redirect_to @commentable, notice: I18n.t("flash.actions.create.notice") }
        format.json { render json: @comment, status: :created, location: @dish }
      else
        render :new
      end
      format.js
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @commentable }
      format.json { head :ok }
      format.js
    end
  end

  private
  def load_commentable
    resource, id = request.path.split('/')[1, 2] # /dishes/1
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  #def load_commentable
    #klass = [Dish, Event].detect { |c| params["#{c.name.underscore}_id"] }
    #@commentable = klass.find(params["#{klass.name.underscore}_id"])
  #end
end
