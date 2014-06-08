  module Api
    module V1
      class TasteProfilesController < ApplicationController
        # before_filter :set_api_user

        def set_api_user
          User.find_by_user_token(params[:user_token])
        end

        def create_profile(user)
          @taste_profile = TasteProfile.new(name: 'hoasdfasdf', user_id: user.id)
        end

        def get_three_suggestions
          x = Echowrap.artist_similar(:name => 'daft punk', :name => "u2")
          user = User.find_by_user_token(params[:user_token])
          create_profile(user) #unless user.taste_profiles.length > 0
          create_echo_nest_taste_profile(user)
          x = Echowrap.artist_similar(:name => 'daft punk', :name => "u2")
          render json: x
        end

        def ban_something #pseudocode
          Echowrap.taste_profile_ban(:id => 'CAUCTMD1404B479E02', :item => 'NewCat-SOYRTFI1374C384A00')
        end

        def make_favorite
          user = User.find_by_user_token(params[:user_token])
          Echowrap.taste_profile_favorite(:id => user.taste_profiles.last.echonest_id, :item => params[:item_id])
          render plain: "1"
        end

        def rate
          user = User.find_by_user_token(params[:user_token])
          x = Echowrap.taste_profile_profile(:id => user.taste_profiles.last.echonest_id)
          puts x.inspect
          Echowrap.taste_profile_rate(:id => user.taste_profiles.last.echonest_id, :item => params[:item_id], :rating => params[:rating])
          render plain: "1"
        end

        def get_favorites
        end

        def get_albums
          artist = params[:artist]
          api_key = Rails.application.secrets.last_fm_key
          response = HTTParty.post("http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist=#{artist}&api_key=#{api_key}&limit=3&format=json")
          puts response
          render plain: '1' 
        end

        private

        def taste_profile_params
          params.require(:taste_profile).(:name, :user_token)
        end

        def create_echo_nest_taste_profile(user)
          @taste_profile = user.taste_profiles.last
          response = Echowrap.taste_profile_create(:name => "#{user.name}#{SecureRandom.hex(10)}", :type => 'artist')
          @taste_profile.echonest_id = response.id
          @taste_profile.save!
          data = []
          music_likes = [{"name" => 'daft_punk'}, {"name" => 'u2'}]

          music_likes.each do |artist|
            artist_hash = {"item" => {"artist_name" => "#{artist['name']}"}}
            data << artist_hash
          end

          Echowrap.taste_profile_update(:id => "#{@taste_profile.echonest_id}", :data => data.to_json)
        end

        def check_token
          @user = User.find_by_user_token(params[:user][:user_token])
          if @user
            render plain: '1'
          else
            render plain: '0'
          end
        end
      end
    end
  end