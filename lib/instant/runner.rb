require 'json'
require 'timeout'

module Instant
  class Runner
    def initialize(processor = Processor.new, timeout=1)
      @processor = processor
      @timeout   = timeout
    end

    def run(source)      
      begin
        @processed = @processor.process(source)
        context = Context.new
        return_value = nil

        begin
          thread = Thread.new do
            $SAFE = 3          
            Timeout::timeout(@timeout) do
              return_value = context.instance_eval(@processed)
            end
          end
          thread.join
        ensure
          context.close
        end
        {:status => :ok, :result => context.to_s, :return_value => return_value}
      rescue SecurityError => e
        {:status => :error, :cause => :security_error, :message => format_error(e), :result => context.to_s }
      rescue SyntaxError => e
        {:status => :error, :cause => :syntax_error, :message => format_error(e), :result => context.to_s }
      rescue Racc::ParseError => e
        {:status => :error, :cause => :parse_error, :message => format_error(e), :result => context.to_s }
      rescue Instant::LoopTooDeepError => e
        {:status => :error, :cause => :loop_too_deep, :message => "Loop too deep", :result => context.to_s }
      rescue Timeout::Error => e
        {:status => :error, :cause => :timeout, :message => "Timeout: code take more than #{@timeout}s to run.", :result => context.to_s }
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