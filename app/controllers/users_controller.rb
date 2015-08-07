class UsersController < ApplicationController

  # Instagram ouauth redirect
  def oauth
    redirect_to Instagram.authorize_url(:redirect_uri => "http://localhost:3000/callback")
  end

  # Instagram oauth callback currently malfunctioning on Instagram's end
  def oauth_callback
    # response = Instagram.get_access_token(params[:code], :redirect_uri => "http://localhost:3000/callback")
    # session[:access_token] = response.access_token

    # user = User.find_or_create_by(instagram_id: response.user.id.to_i) do |user| 
    #   user.name = response.user.full_name }
    #   map = Map.create(user_id: user.id)
    # end
    
    # user.instagram_access_token = response.access_token

    # user.save

    # redirect_to '/users/#{user.id}/complete_signup'
    redirect_to '/'
  end

  # Collect email address
  def complete_signup
    @user = User.find(params[:id])
 
    if request.patch? && params[:user]
      if @user.update(user_params)
        redirect_to "/"
      else
        @show_errors = true
      end
    end

  end

  def import_recent

    @user = User.find(params[:id])
    client = Instagram.client(:access_token => @user.instagram_access_token)
    @photos = []
    client.user_recent_media.each do |media_item|
      unless media_item.location == nil
        photo = {}
        photo[:user_id] = @user.id
        photo[:image_url] = media_item.images.thumbnail.url
        photo[:latitude] = media_item.location.latitude
        photo[:longitude] = media_item.location.longitude
        photo[:saved] = Photo.exists?(image_url: photo[:image_url])

        @photos << photo
      end
    end

    respond_to do |format|
      format.html { render :import_recent }
      format.json { render json: @photos }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def user_params
      accessible = [ :name, :email ]
      params.require(:user).permit(accessible)
    end

end