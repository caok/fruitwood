class PhotoController < ApplicationController
  load_and_authorize_resource

  def create
    files = params[:files].map do |file|
      photo = current_user.photos.create :image => file
      {'url' =>  photo.image_url}
    end
    render json: {files: files}
  end
end
