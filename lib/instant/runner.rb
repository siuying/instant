module Instant
  class Runner
    def initialize(processor = Processor.new)
      @processor = processor
    end

    def run(source)
      @processed = @processor.process(source)
      Context.new.instance_eval(@processed).to_s
    end
  end
end