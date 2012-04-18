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

      Instant::Context.stub(:new => context_stub)
      runner = Instant::Runner.new(processor)
      runner.run(source)
    end
  end
end
