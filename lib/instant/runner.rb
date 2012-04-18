require 'json'

module Instant
  class Runner
    def initialize(processor = Processor.new)
      @processor = processor
    end

    def run(source)      
      begin
        @processed = @processor.process(source)
        context = Context.new

        return_value = context.instance_eval(@processed)
        context.close
        {:status => :ok, :result => context.to_s, :return_value => return_value}
      rescue SyntaxError => e
        {:status => :error, :cause => :syntax_error, :message => format_error(e), :result => context.to_s }
      rescue Racc::ParseError => e
        {:status => :error, :cause => :parse_error, :message => format_error(e), :result => context.to_s }
      rescue Instant::LoopTooDeepError => e
        {:status => :error, :cause => :loop_too_deep, :message => "Loop too deep", :result => context.to_s }
      rescue StandardError => e
        {:status => :error, :cause => :unknown, :message => format_error(e), :result => context.to_s }        
      end
    end
    
    private
    def format_error(e)
      "#{e.message}<br><br>#{ e.backtrace[0..10].join('<br>')}"
    end
  end
end