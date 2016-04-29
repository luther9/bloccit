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
    before(:each) {get :new}

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders the #new view' do
      expect(response).to render_template :new
    end

    it 'instantiates @advertisement' do
      expect(assigns :advertisement).not_to be_nil
    end
  end

  describe "POST #create" do
    before(:each) do
      post :create, advertisement: {
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        price: rand(1...10000)
      }
    end

    it 'increases the number of ads by 1' do
      expect do
        post :create, advertisement: {
          title: RandomData.random_sentence,
          body: RandomData.random_paragraph,
          price: rand(1...10000)
        }
      end.to change(Advertisement, :count).by 1
    end

    it 'assigns the new ad to @advertisement' do
      expect(assigns :advertisement).to eq Advertisement.last
    end

    it 'redirects to the new ad' do
      expect(response).to redirect_to Advertisement.last
    end
  end

end
