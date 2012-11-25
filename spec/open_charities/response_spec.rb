require 'spec_helper'

describe OpenCharities::Response do

  let(:subject) { OpenCharities::Response }

  context "with a successful http response" do
    before do
      url = "http://opencharities.org/charities/1149855.json"
      stub_request(:get, url).to_return(
        :body => load_fixture("veteransheadquarters.json"),
        :status => 200
      )
      @response = subject.new(Faraday.get(url))
    end

    it "loads attributes into the object body" do
      @response["title"].should == "VETERAN'S HEADQUARTERS"
    end

    it "makes raw attributes available as well" do
      @response.attributes["title"].should == "VETERAN'S HEADQUARTERS"
    end

    it "converts top-level hash keys into singleton methods" do
      @response.title.should == "VETERAN'S HEADQUARTERS"
      @response.charity_number.should == "1149855"
    end
  end

  context "with a company that doesn't exist" do
    before do
      @url = "http://opencharities.org/charities/0000000.json"
      stub_request(:get, @url).to_return(
        :body => "Some bullshit HTML response :-(",
        :status => 404
      )
    end

    it "raises an exception" do
      expect {
        subject.new(Faraday.get(@url))
      }.to raise_exception OpenCharities::CharityNotFound
    end
  end

  context "when the server is down" do
    before do
      @url = "http://data.OpenCharities.gov.uk/doc/company/12345678.json"
      stub_request(:get, @url).to_return(
        :body => "Oh noes",
        :status => 500
      )
    end

    it "raises an exception" do
      expect {
        subject.new(Faraday.get(@url))
      }.to raise_exception OpenCharities::ServerError
    end
  end
end
