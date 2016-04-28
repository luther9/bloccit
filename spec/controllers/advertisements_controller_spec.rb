require 'rails_helper'

RSpec.describe AdvertisementsController, type: :controller do
  let :ad do
    Advertisement.create! title: 'Car', body: 'Buy our new Car!', price: 6660
  end

  describe "GET #index" do
    before(:each) {get :index}

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'assigns all ads to @advertisements' do
      expect(assigns :advertisements).to eq [ad]
    end
  end

  describe "GET #show" do
    before(:each) {get :show, id: ad.id}

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders the #show view' do
      expect(response).to render_template :show
    end

    it 'assigns ad to @advertisement' do
      expect(assigns :advertisement).to eq ad
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

end
