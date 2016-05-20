require 'rails_helper'

RSpec.describe LabelsController, type: :controller do
  let :my_label do
    Label.create! name: 'L1'
  end

  describe "GET #show" do
    before :each do
      get :show, id: my_label.id
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      expect(response).to render_template :show
    end

    it "assigns my_label to @label" do
      expect(assigns :label).to eq my_label
    end
  end

end
