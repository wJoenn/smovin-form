require "open-uri"
require_relative "../indexed_rent"

module IndexedRent
  class Calculator
    include IndexedRent

    BASES = [1988, 1996, 2004, 2013]

    def initialize(params = {})
      @params = params.transform_keys(&:to_sym)
    end

    def calculate
      @errors = Validator.new(@params).validate
      return render_failure if @errors.any?

      base_month = calculate_month(@params[:signed_on])
      base = calculate_base(base_month)
      base_index = fetch_index(base, base_month)
      current_month = calculate_month(last_birthday(@params[:start_date]))
      current_index = fetch_index(base, current_month)
      new_rent = calculate_new_rent(@params[:base_rent], base_index, current_index)

      render_success(new_rent, base_index, current_index)
    end

    private

    def calculate_base(date)
      BASES.max do |a, b|
        if a <= year(date)
          b <= year(date) ? a <=> b : 1
        else
          -1
        end
      end
    end

    def calculate_new_rent(base_rent, base_index, current_index)
      (base_rent * current_index).fdiv(base_index).round(2)
    end

    def fetch_index(base, month)
      url = "https://fi7661d6o4.execute-api.eu-central-1.amazonaws.com/prod/indexes/#{base}/#{month}"
      data = JSON.parse(URI.parse(url).read)

      data["index"]["MS_HLTH_IDX"]
    end

    def last_birthday(date)
      current_year = Date.today.strftime("%Y")
      start_month = date[5...]

      return "#{current_year}-#{start_month}" if Date.parse("#{current_year}-#{start_month}") < Date.today

      "#{current_year.to_i - 1}-#{start_month}"
    end

    def render_failure
      @errors
    end

    def render_success(new_rent, base_index, current_index)
      { new_rent:, base_index:, current_index: }
    end
  end
end
