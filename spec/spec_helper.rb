require 'mocha'
require 'json'
require 'webmock/rspec'

require 'open_charities'


RSpec.configure do |config|

  config.before(:suite) do
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  config.mock_with :mocha
end

def load_fixture(*filename)
  File.open(File.join('spec', 'data', *filename)).read
end
