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
class Restorant < ApplicationRecord
  has_many :groups, dependent: :restrict_with_error

  validates :name, presence: true
end
