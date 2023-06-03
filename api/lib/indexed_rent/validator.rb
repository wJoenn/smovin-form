require_relative "../indexed_rent"

module IndexedRent
  class Validator
    include IndexedRent

    REGIONS = %w[brussels wallonia flanders]

    def initialize(params = {})
      @errors = Hash.new { |hash, key| hash[key] = [] }
      @params = params
      @base_rent = @params[:base_rent]
      @region = @params[:region]
      @start_date = @params[:start_date]
      @signed_on = @params[:signed_on]
    end

    def validate
      validates_presence_of base_rent: @base_rent, region: @region, start_date: @start_date, signed_on: @signed_on
      validates_date_of start_date: @start_date, signed_on: @signed_on
      validates_positiveness_of @base_rent unless @errors.key?(:base_rent)
      validates_location_of @region unless @errors.key?(:region)

      @errors
    end

    private

    def validates_date_of(**params)
      params.each do |key, value|
        next if @errors.key?(key)

        param = key.to_s.tr("_", " ").capitalize

        not_in_future = Date.parse(value) < Date.today
        @errors[key] << "#{param} must be in the past" unless not_in_future

        too_ancient = key == :signed_on && year(calculate_month(value)) < 1994
        @errors[key] << "#{param} is too old to be indexable" if too_ancient
      end
    end

    def validates_location_of(region)
      @errors[:region] << "Region must be in Belgium" unless REGIONS.include?(region.downcase)
    end

    def validates_positiveness_of(base_rent)
      @errors[:base_rent] << "Base rent must be positive" unless base_rent.positive?
    end

    def validates_presence_of(**params)
      params.each do |key, value|
        param = key.to_s.tr("_", " ").capitalize
        present = !value.nil? && value != ""

        @errors[key] << "#{param} is missing" unless present
      end
    end
  end
end
