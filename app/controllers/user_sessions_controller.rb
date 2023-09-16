# frozen_string_literal: true

class UserSessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  skip_before_action :authenticate_admin!

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])

    if @user&.authenticate(params[:user][:password])
      session[:user_id] = @user.id

      redirect_to root_path, notice: 'Successfully signed in!'
    else
      redirect_to new_user_session_path, alert: 'Sign in failed!'
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_path, notice: 'Successfully signed out!'
  end
end
