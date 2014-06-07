class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      gflash notice: "You've signed up and we've logged you in."
      redirect_to root_path 
    else
      gflash notice: "We were unable to create your account. Please try again."
      redirect_to root_path
    end
  end

  def dashboard
    @graph = Koala::Facebook::API.new(current_user.facebook_token)
    @music_likes = @graph.get_object("me/music", {}, api_version: "v2.0")
    data = []
    puts @music_likes
    @music_likes.each do |artist|
      puts artist['name']
      artist_hash = {"item" => {"artist_name" => "#{artist['name']}"}}
      puts artist_hash
      data << artist_hash
    end
    x = Echowrap.taste_profile_create(:name => 'oo', :type => 'artist')
    y = Echowrap.taste_profile_update(:id => "#{x.id}", :data => data.to_json)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password_confirmation, :password)
  end

end