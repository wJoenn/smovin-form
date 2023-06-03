require "sinatra"
require "sinatra/cross_origin"
require_relative "./lib/indexed_rent"

configure do
  enable :cross_origin
end

before do
  response.headers["Access-Control-Allow-Origin"] = "*"
end

post "/v1/indexations" do
  params = JSON.parse(request.body.read)
  result = IndexedRent::Calculator.new(params).calculate

  response.status = result.key?(:new_rent) ? 200 : 400
  return result.to_json
end

options "*" do
  response.headers["Allow"] = "POST, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "Content-Type"
  response.headers["Access-Control-Allow-Origin"] = "*"
  200
end
