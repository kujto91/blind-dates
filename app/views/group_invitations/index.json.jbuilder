# frozen_string_literal: true

json.array! @group_invitations, partial: 'group_invitations/group_invitation', as: :group_invitation
