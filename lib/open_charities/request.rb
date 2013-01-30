module OpenCharities

  class Request

    BASE_URI = "http://opencharities.org/charities/%s.json"

    def initialize(reg_number)
      @reg_number = validate(reg_number)
    end

    def perform
      url = BASE_URI % @reg_number
      response = with_caching { Faraday.get(url) }
      Response.new(response)
    end

    private

    def with_caching(&block)
      args = OpenCharities.cache_args || {}
      cache = OpenCharities.cache
      cache ? cache.fetch(@reg_number, args, &block) : yield
    end

    def validate(reg_number)
      number = reg_number.to_s.strip

      # match any 6/7 digit number OR 6/7 digit number followed by a dash and
      # another 1 or 2 numbers
      charities_regex = /\A\d{6,7}\z|\A\d{6,7}\-\d{1,2}\z/

      msg = "#{number} is not a valid UK charity registration number"
      raise InvalidRegistration.new(msg) unless number =~ charities_regex

      number
    end
  end
end
