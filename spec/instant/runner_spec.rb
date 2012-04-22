require 'spec_helper'
require 'pp'

describe Instant::Runner do
  context "#run" do
    it "should process the input" do
      source = "def hello; a = 1; end"
      processed_source = stub(:processed_source)

      processor = stub(:processor)
      processor.should_receive(:process).with(source).and_return(processed_source)
      
      context_stub = stub(:context)
      context_stub.should_receive(:instance_eval).with(processed_source)
      context_stub.should_receive(:close)
      
      Instant::Context.stub(:new => context_stub)
      runner = Instant::Runner.new(processor)
      runner.run(source)
    end
  
    it "should not die in infinite loop" do
      source = "def hello
    k = 1
    i = 2
    while true do
      k = (k - 1)
      i = (i + 1)
    end
  end; hello"
      runner = Instant::Runner.new
      result = runner.run(source)
      result[:status].should == :error
      result[:cause].should == :loop_too_deep
      results = result[:result].split("\n")
      results[0].strip.should =~ /k        =   1/
      results[1].strip.should =~ /i        =   2/
      results[2].strip.should =~ /k        =   0  | -1  | -2  | -3  | -4/
      results[3].strip.should =~ /i        =   0  |  1  |  2  |  3  |  4/
    end
    
    it "should print output in the while loop" do
      source = "def hello
    k = 1
    i = 2
    while true do
      k = (k - 1)
      i = (i + 1)
      
      if k < -5
        return k
      end
    end
  end; hello"

      runner = Instant::Runner.new
      result = runner.run(source)
      result[:status].should == :ok
      results = result[:result].split("\n")

      results.length.should == 4

      results[0].strip.should =~ /k        =   1/
      results[1].strip.should =~ /i        =   2/
      results[2].strip.should =~ /k        =   0  | -1  | -2  | -3  | -4/
      results[3].strip.should =~ /i        =   0  |  1  |  2  |  3  |  4/
    end
    
    it "should guard against slow code" do
      source = "def hello
    k = 1
    sleep(10)
  end; hello"

      runner = Instant::Runner.new
      result = runner.run(source)
      result[:status].should == :error
      result[:cause].should == :timeout

      results = result[:result].split("\n")
      results[0].strip.should =~ /k        =   1/
    end
  end
end
