 module Api
    module V1
      class TasteProfilesController < ApplicationController
        before_filter :set_api_user

        def set_api_user
          User.find_by_user_token(params[:user_token])
        end

        def create
          @taste_profile = TasteProfile.new(taste_profile_params)
          create_echo_nest_taste_profile(@taste_profile)
          if @taste_profile.save
            render json: @taste_profile
          else
            render plain: "0"
          end
        end


        def get_three_suggestions(user_token=1)



        end

        def ban_album
        end

        def make_favorite
        end

        def get_favorites
        end

        private

        def taste_profile_params
          params.require(:taste_profile).(:name, :user_token)
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