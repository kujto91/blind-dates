# frozen_string_literal: true

# == Schema Information
#
# Table name: restorants
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  descripton       :text
#  phone            :string
#  address_street   :string
#  address_number   :string
#  address_postcode :string
#  address_town     :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :restorant do
    name { Forgery(:name).company_name }
    descripton { Forgery('basic').text }
    phone { Forgery('address').phone }
    address_street { Forgery('address').street_name }
    address_number { Forgery('address').street_number }
    address_postcode { Forgery('address').zip }
    address_town { Forgery('address').city }
  end
end
