# frozen_string_literal: true

# == Schema Information
#
# Table name: groups
#
#  id           :bigint           not null, primary key
#  restorant_id :bigint
#  week         :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Group < ApplicationRecord
  belongs_to :restorant, optional: true

  has_many :group_invitations, dependent: :destroy
  has_many :confirmed_group_invitations, -> { confirmed }, class_name: 'GroupInvitation', inverse_of: :group, dependent: :destroy
  has_many :participants, through: :confirmed_group_invitations, source: :user

  has_one :leader_group_invitation, -> { leaders }, class_name: 'GroupInvitation', inverse_of: :group, dependent: :destroy
  has_one :leader, through: :leader_group_invitation, source: :user

  validates :week, presence: true

  def self.calculate_this_week_number
    Time.now.strftime('%U').to_i
  end

  def participant_names
    return if participants.blank?

    participants.map(&:name).join(', ')
  end
end
