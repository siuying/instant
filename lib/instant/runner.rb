module Instant
  class Runner
    def initialize
      @processor = Processor.new
    end

    def run(source)
      @processed = @processor.parse(source)
    end
  end
end