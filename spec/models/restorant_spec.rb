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
require 'rails_helper'

RSpec.describe Restorant do
  describe 'validations' do
    %i[name].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
  end
end
