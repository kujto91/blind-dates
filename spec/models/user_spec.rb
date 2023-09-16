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
require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    %i[first_name last_name email].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end

    %i[department].each do |attribute|
      it { is_expected.to belong_to(attribute) }
    end
  end
end
