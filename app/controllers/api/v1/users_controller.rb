module Api
  module V1
    class UsersController < ApplicationController

      def create
        @user = User.new(user_params)
        if @user.save
          token = create_token
          @user.user_token = token
          @user.save
          
          render json: @user
        else
          render plain: '0'
        end
      end

      def session_create
        @user = User.find_by_email(params[:user][:email]).try(:authenticate, params[:user][:password])
        if @user
          token = create_token
          @user.user_token = token
          @user.save
          render json: @user
        else
          render plain: '0'
        end
      end

      def check_token
        @user = User.find_by_user_token(params[:user][:user_token])
        if @user
          render plain: '1'
        else
          render plain: '0'
        end
      end

      def create_token
        SecureRandom.hex(10)
      end

      def session_destroy
        @user = User.find_by_email(params[:user][:email])
        @user.user_token = nil
        @user.save
        render json: @user
      end

      private

      def user_params
        params.require(:user).permit(:email, :name, :password, :user_token)
      end

    end
  end
end