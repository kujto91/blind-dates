# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  department_id   :bigint           not null
#  first_name      :string           not null
#  last_name       :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  admin           :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :user do
    department { { strategy: :find_or_create } }

    first_name { Forgery('name').first_name }
    last_name { Forgery('name').last_name }
    email { Forgery('internet').email_address }
    password { 'password!' }

    trait :admin do
      admin { true }
    end
  end
end
