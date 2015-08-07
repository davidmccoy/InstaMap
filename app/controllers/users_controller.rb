class UsersController < ApplicationController

  # Instagram ouauth redirect
  def oauth
    redirect_to Instagram.authorize_url(:redirect_uri => "http://localhost:3000/callback")
  end

  # Instagram oauth callback currently malfunctioning on Instagram's end
  def oauth_callback
    # response = Instagram.get_access_token(params[:code], :redirect_uri => "http://localhost:3000/callback")
    # session[:access_token] = response.access_token

    # user = User.find_or_create_by(instagram_id: response.user.id.to_i) { |user| user.name = response.user.full_name }
    
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
    binding.pry
    
    @user = User.find(params[:id])
    client = Instagram.client(:access_token => @user.instagram_access_token)
    user = client.user
    html = "<h1>#{user.username}'s recent media</h1>"
    client.user_recent_media.each do |media_item|
      html << "<div style='float:left;'>
                <img src='#{media_item.images.thumbnail.url}'>
                <br/> 
                <a href='/users/#{@user.id}/photos/import/#{media_item.id}'>Add to map</a>
              </div>"
    end

    respond_to do |format|
      format.html { render :text => html }
      
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