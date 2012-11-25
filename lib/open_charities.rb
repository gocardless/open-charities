require 'faraday'
require 'json'
require 'open_charities/request'
require 'open_charities/response'

module OpenCharities

  class CharityNotFound < StandardError
  end

  class InvalidRegistration < StandardError
  end

  class ServerError < StandardError
  end

  class << self

    def lookup(reg_number)
      Request.new(reg_number).perform
    end

    attr_accessor :cache, :cache_args

  end

end
