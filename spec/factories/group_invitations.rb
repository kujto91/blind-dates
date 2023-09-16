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
FactoryBot.define do
  factory :group_invitations do
    user { { strategy: :find_or_create } }
    group { { strategy: :find_or_create } }

    trait :leader do
      leader { true }
    end

    trait :confirmed do
      confirmed_at { DateTime.now }
    end
  end
end
