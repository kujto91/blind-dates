# frozen_string_literal: true

# == Schema Information
#
# Table name: departments
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  descripton :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Department do
  describe 'validations' do
    %i[name].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
  end
end
