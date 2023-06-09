module IndexedRent
  def calculate_month(string_date)
    date = Date.parse(string_date)
    base_date = date.prev_month

    base_date.strftime("%Y-%m")
  end

  def year(date)
    date.split("-").first.to_i
  end
end

require_relative "indexed_rent/calculator"
require_relative "indexed_rent/validator"
