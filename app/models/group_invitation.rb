# frozen_string_literal: true

# == Schema Information
#
# Table name: group_invitations
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  group_id     :bigint           not null
#  leader       :boolean          default(FALSE)
#  confirmed_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class GroupInvitation < ApplicationRecord
  scope :confirmed, -> { where.not(confirmed_at: nil) }
  scope :leaders, -> { where(leader: true) }

  belongs_to :user
  belongs_to :group

  def confirmed?
    confirmed_at.present?
  end

  def confirm!
    update!(confirmed_at: DateTime.now)
  end
end
