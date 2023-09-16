# frozen_string_literal: true

class GroupInvitationsController < ApplicationController
  skip_before_action :authenticate_admin!
  before_action :set_group_invitation, only: %i[edit update destroy]

  def index
    @group_invitations = group_invitations
  end

  def edit; end

  def update
    respond_to do |format|
      if current_user.admin? || current_user == group_invitation.leader
        if @group_invitation.confirm!
          format.html { redirect_to group_invitations_url, notice: 'Group Invitation was successfully updated.' }
          format.json { render :index, status: :ok }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @group_invitation.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to group_invitations_url, alert: 'Unauthorized action.' }
        format.json { head :unauthorized }
      end
    end
  end

  def destroy
    @group_invitation.destroy!

    respond_to do |format|
      format.html { redirect_to group_invitations_url, notice: 'Group Invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_group_invitation
    @group_invitation = group_invitations.find(params[:id])
  end

  def group_invitations
    @group_invitations = current_user.admin? ? GroupInvitation.all : current_user.group_invitations
  end

  def group_invitation_params
    params.require(:group_invitation).permit(:confirm)
  end
end
