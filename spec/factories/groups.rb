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
FactoryBot.define do
  factory :groups do
    restorant { { strategy: :find_or_create } }
    week { Group.calculate_this_week_number }
  end
end
