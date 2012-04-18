require 'spec_helper'
require 'instant'
require 'pp'

describe Instant do
  let(:parser) { RubyParser.new }
  
  it "should log assignment in method arguments" do
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

  it "should log assignment with operator" do
    source = "def hello
  a = 1
  b = 2
  c = a + b
end"
    expected = "def hello
  a = LogAssign(:a, 1)
  b = LogAssign(:b, 2)
  c = LogAssign(:c, (a + b))
end"

    subject = Instant.new source
    subject.processed.should == expected.strip
  end  
  
  it "should log while loop" do
    source = "def hello
  i = 0
  k = 0
  while (i < 5) do
    k = (k - 1)
    i = (i + 1)
  end
end"

    expected = "def hello
  i = LogAssign(:i, 0)
  k = LogAssign(:k, 0)
  BeginLoop
  while (i < 5) do
    BeginInsideLoop
    (k = LogAssign(:k, (k - 1))
    i = LogAssign(:i, (i + 1)))
    EndInsideLoop
  end
  EndLoop
end"

    pp parser.process(source)
    pp parser.process(expected)
    subject = Instant.new source
    subject.processed.should == expected.strip
  end

  it "should log method arguments"
  it "should log return"

end