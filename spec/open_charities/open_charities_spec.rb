require 'spec_helper'

describe OpenCharities do

  let(:subject) { OpenCharities }

  describe ".lookup" do
    it "initializes a request" do
      OpenCharities::Request.expects(:new).with("1234567").
        returns(stub(perform: true))
      subject.lookup("1234567")
    end

    it "calls perform on the request and returns the response" do
      OpenCharities::Request.stubs(:new).with("1234567").
        returns(mock(perform: true))
      subject.lookup("1234567")
    end

  end

end
