require 'spec_helper'
require 'instant'
require 'pp'

describe Instant do
  let(:parser) { RubyParser.new }
  
  it "should log assignment in parameter" do
    source = "def hello(a=1)
  a = 2
end"
    expected = "def hello(a = LogAssign(:a, 1))
  a = LogAssign(:a, 2)
end"

    subject = Instant.new source
    subject.processed.should == expected.strip
  end

  it "should log simple assignment" do
    source = "def hello
  a = 1
end"
    expected = "def hello
  a = LogAssign(:a, 1)
end"

    subject = Instant.new source
    subject.processed.should == expected.strip
  end
  
end