require 'spec_helper'
require 'pp'

describe Instant::Processor do
  let(:parser) { RubyParser.new }
  
  it "should log assignment in method arguments" do
    source = "def hello(a=1)
  a = 2
end"
    expected = "def hello(a = log_assign(:a, 1))
  a = log_assign(:a, 2)
end"

    subject.process(source).should == expected.strip
  end

  it "should log simple assignment" do
    source = "def hello
  a = 1
end"
    expected = "def hello
  a = log_assign(:a, 1)
end"

    subject.process(source).should == expected.strip
  end

  it "should log assignment with operator" do
    source = "def hello
  a = 1
  b = 2
  c = a + b
end"
    expected = "def hello
  a = log_assign(:a, 1)
  b = log_assign(:b, 2)
  c = log_assign(:c, (a + b))
end"

    subject.process(source).should == expected.strip
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
  i = log_assign(:i, 0)
  k = log_assign(:k, 0)
  loop_begin
  while (i < 5) do
    loop_inside_begin
    (k = log_assign(:k, (k - 1))
    i = log_assign(:i, (i + 1)))
    loop_inside_end
  end
  loop_end
end"

    subject.process(source).should == expected.strip
  end
  
  it "should log if in while loop" do
    source = "def hello
  i = 0
  j = 0
  k = 0
  while (i < 5) do
    if i < 3
      k = (k + i)
    else
      j = (j + i)
    end
    i = (i + 1)
  end
end"

    expected = "def hello
  i = log_assign(:i, 0)
  j = log_assign(:j, 0)
  k = log_assign(:k, 0)
  loop_begin
  while (i < 5) do
    loop_inside_begin
    ((i < 3) ? (k = log_assign(:k, (k + i))) : (j = log_assign(:j, (j + i)))
    i = log_assign(:i, (i + 1)))
    loop_inside_end
  end
  loop_end
end"

    # pp parser.process source
    # pp parser.process expected 

    subject.process(source).should == expected.strip
  end
  
  it "should render while loop with return" do
    source = "def hello
  k = 1
  i = 2
  while true do
    k = (k - 1)
    i = (i + 1)
      
    if k < 10
      return k
    end
  end
end
hello"

    expected = "def hello
  k = log_assign(:k, 1)
  i = log_assign(:i, 2)
  loop_begin
  while true do
    loop_inside_begin
    (k = log_assign(:k, (k - 1))
    i = log_assign(:i, (i + 1))
    return k if (k < 10))
    loop_inside_end
  end
  loop_end
end
hello"
    #pp parser.process source
    #pp parser.process expected 

    subject.process(source).strip.should == expected
  end

  it "should log method arguments"
  it "should log return"

end