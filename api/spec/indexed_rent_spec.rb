require "json"
require 'rack/test'
require_relative "../app"
require_relative "../lib/indexed_rent"

def parsed_params(params)
  JSON.parse(params.to_json)
end

def some_time_ago(years = 0, months = 0, days = 0)
  Date.today - (365.25 * years).round - (30.437 * months).round - (days)
end

describe Sinatra::Application do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "POST /v1/indexations" do
    it "returns http ok" do
      params = { base_rent: 10, region: "brussels", start_date: some_time_ago(20, -3), signed_on: some_time_ago(20) }
      post "/v1/indexations", params.to_json

      expect(last_response.status).to eq(200)
    end

    it "returns http bad request" do
      post "/v1/indexations", {}.to_json
      expect(last_response.status).to eq(400)
    end
  end
end

describe IndexedRent::Calculator do
  describe "#calculate" do
    it "returns missing error messages" do
      result = IndexedRent::Calculator.new.calculate

      expect(result.values.flatten).to all include "missing"
    end

    it "returns specific error messages if present but wrong" do
      params = { base_rent: -10, region: "Paris", start_date: Date.today + 1, signed_on: Date.today + 1 }
      result = IndexedRent::Calculator.new(parsed_params(params)).calculate

      expect(result[:base_rent].first).to include "positive"
      expect(result[:region].first).to include "Belgium"
      expect(result[:start_date].first).to include "past"
      expect(result[:signed_on].first).to include "past"

      params = { base_rent: -10, region: "Paris", start_date: Date.today + 1, signed_on: some_time_ago(100) }
      result = IndexedRent::Calculator.new(parsed_params(params)).calculate

      expect(result[:signed_on].first).to include "too old"
    end

    it "returns the new rent, the base index and the current index" do
      params = { base_rent: 10, region: "brussels", start_date: some_time_ago(20, -3), signed_on: some_time_ago(20) }
      result = IndexedRent::Calculator.new(parsed_params(params)).calculate

      expect(result[:new_rent]).to be_a Numeric
      expect(result[:base_index]).to be_a Numeric
      expect(result[:current_index]).to be_a Numeric
    end
  end
end
