class PhotosController < ApplicationController

  def create

    photo = Photo.create(photo_params)

    respond_to do |format|
      format.json { render json: photo }
    end

  end

  private

    def photo_params
      accessible = [ :user_id, :image_url, :latitude, :longitude ]
      params.require(:photo).permit(accessible)
    end

end