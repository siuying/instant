require 'spec_helper'
require 'instant'
require 'pp'

describe Instant do
  let(:parser) { RubyParser.new }

  it "should replace simple assignment" do
    source = "def hello
  a = 1
end"
    expected = "def hello
  a = LogObject(:a, 1)
end"

    subject = Instant.new source
    subject.processed.should == expected.strip
  end

end