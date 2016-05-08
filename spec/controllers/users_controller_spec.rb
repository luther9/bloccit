require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let :new_user_attributes do
    {
      name: "BlocHead",
      email: "blochead@bloc.io",
      password: "blochead",
      password_confirmation: "blochead"
    }
  end

  describe 'GET new' do
    before(:each) {get :new}

    it 'returns http success' do
      expect(response).to have_http_status :success
    end

    it 'instantiates a new user' do
      expect(assigns :user).to_not be_nil
    end
  end

  describe 'POST create' do
    before(:each) {post :create, user: new_user_attributes}

    it 'returns an http redirect' do
      expect(response).to have_http_status :redirect
    end

    it 'creates a new user' do
      expect do
        post :create, user: new_user_attributes
      end.to change(User, :count).by 1
    end

    it 'sets user name properly' do
      expect(assigns(:user).name).to eq new_user_attributes[:name]
    end

    it 'sets user email properly' do
      expect(assigns(:user).email).to eq new_user_attributes[:email]
    end

    it 'sets user password properly' do
      expect(assigns(:user).password).to eq new_user_attributes[:password]
    end

    it 'sets user password_confirmation properly' do
      expect(assigns(:user).password_confirmation).to eq new_user_attributes[:password_confirmation]
    end
  end
end
