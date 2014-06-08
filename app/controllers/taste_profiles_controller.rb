class TasteProfilesController < ApplicationController

  def create
    @taste_profile = TasteProfile.new(taste_profile_params)
    if @taste_profile.save
      create_echo_nest_taste_profile(@taste_profile)
      gflash notice: "Your taste profile has been created!"
      redirect_to :back
    else
      gflash notice: "Something went wrong. Please try again. Keep in mind that your taste profile name must be unique."
      redirect_to :back
    end
  end

  def show
    @taste_profile = TasteProfile.find(params[:id])
    taste_profile_data = Echowrap.taste_profile_read(:id => @taste_profile.echonest_id)
    artist = taste_profile_data.items.sample
    @similar_artists = Echowrap.artist_similar(:id => artist.artist_id, :results => 3)
  end

  def get_similar
    @similar_artists = Echowrap.taste_profile_similar()
  end

  private

  def get_facebook_data
    @graph = Koala::Facebook::API.new(current_user.facebook_token)
    @music_likes = @graph.get_object("me/music", {}, api_version: "v2.0")
  end

  def taste_profile_params
    params.require(:taste_profile).permit(:name, :echonest_id, :user_id)
  end

  def create_echo_nest_taste_profile(taste_profile)
    response = Echowrap.taste_profile_create(:name => taste_profile_params[:name], :type => 'artist')
    @taste_profile.echonest_id = response.id
    @taste_profile.save!
    data = []
    @music_likes = get_facebook_data

    @music_likes.each do |artist|
      puts artist['name']
      artist_hash = {"item" => {"artist_name" => "#{artist['name']}"}}
      puts artist_hash
      data << artist_hash
    end

    Echowrap.taste_profile_update(:id => "#{@taste_profile.echonest_id}", :data => data.to_json)
  end

end