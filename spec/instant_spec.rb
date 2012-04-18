require 'spec_helper'

describe Instant do
  it "should replace simple assignment" do
    source = "def hello; a = 1; end"
    expected = "def hello; a = LogObject(:a, 1)"
    subject.source = source
    subject.processed.should == expected
  end
end