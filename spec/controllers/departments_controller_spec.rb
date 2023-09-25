# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DepartmentsController do
  resources = :departments

  let!(:department) { create(:department) }
  let!(:user) { create(:user, department: department) }
  let!(:admin_user) { create(:user, :admin, department: department) }

  let(:collection_params) do
    {
      format: 'json'
    }
  end

  let(:member_params) do
    collection_params.merge(id: department.id)
  end

  let(:create_params) do
    collection_params.merge!(
      department: {
        name: Forgery(:name).company_name,
        descripton: Forgery('basic').text
      }
    )
  end

  let(:update_params) do
    member_params.merge!({ department: department.attributes })
  end

  context 'with user not logged in' do
    describe '#index' do
      before { get :index, params: collection_params }

      it { expect(response).to have_http_status(:found) }
    end

    describe '#create' do
      before { post :create, params: create_params }

      it { expect(response).to have_http_status(:found) }
    end

    describe '#update' do
      before { put :update, params: update_params }

      it { expect(response).to have_http_status(:found) }
    end

    describe '#destroy' do
      before { delete :destroy, params: member_params }

      it { expect(response).to have_http_status(:found) }
    end
  end

  context 'with user logged in' do
    before { login user }

    describe '#index' do
      before { get :index, params: collection_params }

      it { expect(response).to have_http_status(:ok) }
      it { expect(assigns(resources).size).to eq(1) }
      it { expect(assigns(resources)).to include(department) }
    end

    describe '#create' do
      before { post :create, params: create_params }

      it { expect(response).to have_http_status(:found) }
    end

    describe '#update' do
      before { put :update, params: update_params }

      it { expect(response).to have_http_status(:found) }
    end

    describe '#destroy' do
      before { delete :destroy, params: member_params }

      it { expect(response).to have_http_status(:found) }
    end
  end

  context 'with admin user logged in' do
    before { login admin_user }

    describe '#index' do
      before { get :index, params: collection_params }

      it { expect(response).to have_http_status(:ok) }
      it { expect(assigns(resources).size).to eq(1) }
      it { expect(assigns(resources)).to include(department) }
    end

    describe '#create' do
      before { post :create, params: create_params }

      it { expect(response).to have_http_status(:created) }
    end

    describe '#update' do
      before { put :update, params: update_params }

      it { expect(response).to have_http_status(:ok) }
    end

    describe '#destroy' do
      before { delete :destroy, params: member_params }

      it { expect(response).to have_http_status(:no_content) }
    end
  end
end
