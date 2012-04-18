require 'json'

module Instant
  class Runner
    def initialize(processor = Processor.new)
      @processor = processor
    end

    def run(source)
      @processed = @processor.process(source)
      context = Context.new
      
      begin
        return_value = context.instance_eval(@processed)
        context.close
        {:status => :ok, :result => context.to_s, :return_value => return_value}
      rescue Racc::ParseError => e
        {:status => :error, :cause => :parse_error, :message => e.message, :result => context.to_s }
      rescue Instant::LoopTooDeepError => e
        {:status => :error, :cause => :loop_too_deep, :message => "Loop too deep", :result => context.to_s }
      rescue StandardError => e
        {:status => :error, :cause => :unknown, :message => e.message, :result => context.to_s }        
      end
    end
  end
end