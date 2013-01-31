class PhotoController < ApplicationController
  load_and_authorize_resource

  def create
    files = params[:files].map do |file|
      photo = current_user.photos.create :image => file
      image_url = photo.image_url
      image_name = File.basename(image_url, File.extname(image_url))
      { :name => image_name, :url => image_url }
    end
    render json: {files: files}
  end
end
