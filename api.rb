require "open-uri"
require "json"

data = JSON.parse(URI.parse("https://fi7661d6o4.execute-api.eu-central-1.amazonaws.com/prod/indexes/").read)
not_indexable = data["indexes"].select { |index| index["MS_HLTH_IDX"].nil? }
p not_indexable.map { |index| index["SK"] }.tally.sort_by { |k, _v| k }.to_h
