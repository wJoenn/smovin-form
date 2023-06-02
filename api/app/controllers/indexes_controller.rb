require "open-uri"

class IndexesController < ApplicationController
  BASES = [1988, 1996, 2004, 2013]
  REGIONS = %w[brussels wallonia flanders]

  def indexations
    @errors = Hash.new { |hash, key| hash[key] = [] }
    validates(params)
    return render_failure if @errors.any?

    base_month = calculate_month(params[:signed_on])
    base = calculate_base(base_month)
    base_index = fetch_index(base, base_month)
    current_month = calculate_month(last_birthday(params[:start_date]))
    current_index = fetch_index(base, current_month)
    new_rent = calculate_new_rent(params[:base_rent], base_index, current_index)

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

  def calculate_month(string_date)
    date = Date.parse(string_date)
    base_date = date - 1.month

    base_date.strftime("%Y-%m")
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
    current_year = Date.current.strftime("%Y")
    start_month = date[5...]

    "#{current_year}-#{start_month}"
  end

  def render_failure
    render json: @errors, status: :bad_request
  end

  def render_success(new_rent, base_index, current_index)
    render json: { new_rent:, base_index:, current_index: }, status: :ok
  end

  def validates(params)
    if validates_presence_of("base_rent", params[:base_rent]) && !params[:base_rent].positive?
      @errors["base_rent"] << "must_be_positive"
    end

    if validates_presence_of("region", params[:region]) && REGIONS.exclude?(params[:region].downcase)
      @errors["region"] << "must_be_in_belgium"
    end

    if validates_presence_of("start_date", params[:start_date])
      validates_not_in_future("start_date", params[:start_date])
    end

    validates_not_in_future("signed_on", params[:signed_on]) if validates_presence_of("signed_on", params[:signed_on])
  end

  def validates_not_in_future(key, param)
    not_in_future = Date.parse(param) < Time.current
    @errors[key] << "must_be_in_the_past" unless not_in_future
  end

  def validates_presence_of(key, param)
    present = !param.nil? && param != ""
    @errors[key] << "missing" unless present

    present
  end

  def year(date)
    date.split("-").first.to_i
  end
end
