# frozen_string_literal: true

require 'rails_helper'

describe GroupsService do
  let(:departments) { create_list(:department, 2) }
  let(:employees) { departments.each { |department| create_list(:user, 5, department: department) } }

  let(:groups_service) { described_class.new.generate }

  describe '#generate' do
    before do
      employees
      groups_service
    end

    let(:groups) { Group.all }
    let(:group_invitations) { GroupInvitation.all }

    it { expect(groups.count).to eq 3 }
    it { expect(group_invitations.count).to eq 10 }
    it { expect(group_invitations.leaders.count).to eq 3 }
    it { expect(groups.map { |g| g.group_invitations.count }).to eq [4, 3, 3] }
  end
end
