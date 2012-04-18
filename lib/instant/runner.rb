module Instant
  class Runner
    def initialize(processor = Processor.new)
      @processor = processor
    end

    def run(source)
      @processed = @processor.process(source)
      context = Context.new
      return_value = context.instance_eval(@processed)
      {:result => context.to_s, :return_value => return_value}
    end
  end
end