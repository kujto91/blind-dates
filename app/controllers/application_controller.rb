# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :authenticate_user!, :authenticate_admin!

  def authenticate_user!
    redirect_to new_user_session_path, alert: 'User must be signed in!' if current_user.blank?
  end

  def authenticate_admin!
    redirect_to root_url, alert: 'Unauthorized action!'  unless current_user.try(:admin?)
  end

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end
end
