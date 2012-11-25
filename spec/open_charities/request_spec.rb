require 'spec_helper'

describe OpenCharities::Request do

  let(:subject) { OpenCharities::Request }

  describe "#new" do
    context "throws an exception" do
      it "with a number that's too short" do
        expect {
          subject.new "123456"
        }.to raise_exception OpenCharities::InvalidRegistration
      end

      it "that's too long" do
        expect {
          subject.new "12345678"
        }.to raise_exception OpenCharities::InvalidRegistration
      end

      it "that's nil" do
        expect {
          subject.new nil
        }.to raise_exception OpenCharities::InvalidRegistration
      end

      it "that contains spaces" do
        expect {
          subject.new "1234 ABC"
        }.to raise_exception OpenCharities::InvalidRegistration
      end

      it "that contains non alphanumeric chars" do
        expect {
          subject.new "1234?456"
        }.to raise_exception OpenCharities::InvalidRegistration
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
