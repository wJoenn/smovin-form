require "rails_helper"

RSpec.describe IndexesController, type: :request do
  describe "POST #indexation" do
    it "returns http bad request" do
      post "/v1/indexations"
      expect(response).to have_http_status :bad_request
    end

    it "returns missing error messages" do
      post "/v1/indexations"
      data = response.parsed_body

      expect(data["base_rent"]).to include "missing"
      expect(data["region"]).to include "missing"
      expect(data["start_date"]).to include "missing"
      expect(data["signed_on"]).to include "missing"
    end

    it "returns specific error messages if present but wrong" do
      wrong_params = { base_rent: -10, region: "Paris", start_date: Date.tomorrow, signed_on: Date.tomorrow }
      post "/v1/indexations", params: wrong_params, as: :json
      data = response.parsed_body

      expect(data["base_rent"]).to include "must_be_positive"
      expect(data["region"]).to include "must_be_in_belgium"
      expect(data["start_date"]).to include "must_be_in_the_past"
      expect(data["signed_on"]).to include "must_be_in_the_past"
    end

    it "returns http ok" do
      params = { base_rent: 10, region: "brussels", start_date: 20.years.ago, signed_on: Date.yesterday }
      post "/v1/indexations", params:, as: :json

      expect(response).to have_http_status :ok
    end

    it "returns the new rent, the base index and the current index" do
      params = { base_rent: 10, region: "brussels", start_date: 20.years.ago, signed_on: 20.years.ago }
      post "/v1/indexations", params:, as: :json
      data = response.parsed_body

      expect(data["new_rent"]).to be_a Numeric
      expect(data["base_index"]).to be_a Numeric
      expect(data["current_index"]).to be_a Numeric
    end
  end
end
