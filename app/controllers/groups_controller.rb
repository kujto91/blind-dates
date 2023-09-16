# frozen_string_literal: true

class GroupsController < ApplicationController
  skip_before_action :authenticate_admin!, only: %i[index edit update]
  before_action :set_group, only: %i[edit update destroy]
  before_action :set_restorants, only: %i[edit update]

  def index
    @groups = params[:search].present? ? groups.where(week: params[:search]) : groups
  end

  def edit; end

  def create
    respond_to do |format|
      if check_for_current_week_groups
        format.html { redirect_to groups_url, alert: 'Groups already exists.' }
        format.json { head :bad_request }
      elsif GroupsService.new.generate
        format.html { redirect_to groups_url, notice: 'Groups where successfully created.' }
        format.json { render :index, status: :ok }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { head :bad_request }
      end
    end
  end

  def update
    respond_to do |format|
      if current_user.admin? || current_user == group.leader
        if @group.update(group_params)
          format.html { redirect_to groups_url, notice: 'Group was successfully updated.' }
          format.json { render :index, status: :ok }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @group.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to groups_url, alert: 'Unauthorized action.' }
        format.json { head :unauthorized }
      end
    end
  end

  def destroy
    @group.destroy!

    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def check_for_current_week_groups
    Group.where(week: Group.calculate_this_week_number).any?
  end

  def set_group
    @group = groups.find(params[:id])
  end

  def set_restorants
    @restorants = Restorant.all
  end

  def groups
    @groups ||= Group.all
  end

  def group_params
    params.require(:group).permit(:restorant_id)
  end
end
