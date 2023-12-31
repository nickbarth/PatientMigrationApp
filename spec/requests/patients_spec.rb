require 'rails_helper'

RSpec.describe "Patients", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/patients/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /import" do
    it "returns http success" do
      get "/patients/import"
      expect(response).to have_http_status(:success)
    end
  end

end
