# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_admin!, only: %i[index edit update]
  before_action :set_user, only: %i[edit update destroy]
  before_action :departments, only: %i[new create edit update]

  def index
    @users = users
  end

  def new
    @user = users.new
  end

  def edit; end

  def create
    @user = users.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'User was successfully created.' }
        format.json { render :index, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if current_user.admin? || current_user == @user
        if @user.update(user_params)
          format.html { redirect_to users_url, notice: 'User was successfully updated.' }
          format.json { render :index, status: :ok }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to users_url, alert: 'Unauthorized action.' }
        format.json { head :unauthorized }
      end
    end
  end

  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = users.find(params[:id])
  end

  def departments
    @departments ||= Department.all
  end

  def users
    @users ||= User.all
  end

  def user_params
    user_params = permitted_params
    user_params.merge!(admin: params['user']['admin']) if current_user.admin?
    user_params.merge!(department_id: params['user']['department_id']) if current_user.admin?

    user_params
  end

  def permitted_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
