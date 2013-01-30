require 'spec_helper'

describe OpenCharities::Request do

  let(:subject) { OpenCharities::Request }

  describe "#new" do
    context "throws an exception" do
      %W(12345 12345678 #{"123 ABC"} #{"123?!56"}).each do |n|
        specify do
          expect {
            subject.new n
          }.to raise_exception OpenCharities::InvalidRegistration
        end
      end

      it "that's nil" do
        expect {
          subject.new nil
        }.to raise_exception OpenCharities::InvalidRegistration
      end
    end

    context 'is valid' do
      %w(123456 1234567 123456-1 1234567-1 123456-12 1234567-12).each do |n|
        specify do
          expect { subject.new(n) }.to_not raise_exception
        end
      end
    end
  end


  describe "perform" do

    before { @request = subject.new("1149855") }

    it "makes an http request" do
      OpenCharities::Response.stubs(:new)
      Faraday.expects(:get).with("http://opencharities.org/charities/1149855.json")
      @request.perform
    end

    it "passes the response to a Response object" do
      stub_response = stub
      OpenCharities::Response.expects(:new).with(stub_response)
      Faraday.stubs(:get).returns(stub_response)
      @request.perform
    end

    it "caches the request (if enabled)" do
      cached_response = stub
      cache_stub = stub(fetch: cached_response)
      OpenCharities.cache = cache_stub # configure
      OpenCharities::Response.expects(:new).with(cached_response)
      @request.perform
    end
  end
end
