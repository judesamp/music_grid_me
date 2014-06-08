  module Api
    module V1
      class TasteProfilesController < ApplicationController
        # before_filter :set_api_user

        def set_api_user
          User.find_by_user_token(params[:user_token])
        end

        def create_profile(user)
          name = "#{user.name}#{SecureRandom.hex(10)}"
          @taste_profile = TasteProfile.new(name: name, user_id: user.id)
        end

        def get_three_suggestions
          incoming1 = params[:artists][:artist_1]
          puts incoming1
          incoming2 = params[:artists][:artist_2]
          puts incoming2
          incoming3 = params[:artists][:artist_3]
          puts incoming3
          offset = params[:artists][:offset].to_i
          user = User.find_by_user_token(params[:user_token])
          create_profile(user)
          create_echo_nest_taste_profile(user)
          similar_artist = Echowrap.artist_similar(:name => incoming1, :name => incoming2, :name => incoming3, :results => 1, :start => offset)
          artist_name = similar_artist[0].name
          scrubbed_artist_name = artist_name.downcase.gsub(' ', '+')
          album = get_album(scrubbed_artist_name)
          render json: album
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
          Echowrap.taste_profile_rate(:id => user.taste_profiles.last.echonest_id, :item => params[:item_id], :rating => params[:rating])
          render plain: "1"
        end

        def get_favorites
        end

        def get_album(artist_name)
          api_key = Rails.application.secrets.last_fm_key
          url_string = "http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist=#{artist_name}&api_key=9c6a019a0aeb9c3dd7d95d53a1e9ca11&format=json&limit=1"
          HTTParty.get(url_string)
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