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
require 'rails_helper'

RSpec.describe GroupInvitation do
  describe 'validations' do
    %i[user group].each do |attribute|
      it { is_expected.to belong_to(attribute) }
    end
  end
end
