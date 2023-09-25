# frozen_string_literal: true

module ControllerMacros
  def login(user)
    @current_user = user

    session[:user_id] = @current_user.id
  end

  def current_user
    @current_user
  end
end
