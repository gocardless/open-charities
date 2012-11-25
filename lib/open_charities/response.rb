module OpenCharities

  class Response

    attr_reader :attributes


    def initialize(response)
      check_for_errors(response)
      parse_response(response)
    end


    def [](key)
      @attributes[key]
    end

    private

    def check_for_errors(response)
      if response.status == 404
        msg = "Charity (reg. number %s) not found" % @reg_number
        raise CharityNotFound.new(msg)
      end

      unless response.status == 200
        msg = "OpenCharities responded with status #{response.status}"
        raise ServerError.new(msg)
      end
    end

    def parse_response(response)
      body = response.body.encode("UTF-8", "ISO-8859-1")
      data = JSON.parse(body)
      @attributes = data["charity"]

      generate_convenience_methods
    end

    # convert the top-level keys in the returned JSON to singleton methods on
    # the instance
    # NOTE: this *only* converts keys that are in the top-level.
    # for example, instance.address returns a hash, but title returns a string
    def generate_convenience_methods
      @attributes.each_pair do |k, v|
        self.define_singleton_method(k) { v }
      end
    end

  end

end
