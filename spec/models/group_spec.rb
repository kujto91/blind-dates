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
require 'rails_helper'

RSpec.describe Group do
  describe 'validations' do
    %i[week].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
  end
end
