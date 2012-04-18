require 'logger'
require 'stringio'

module Instant
  class LogCollector
    def initialize
      @logs = {}
    end
    
    def append(key, value)
      @logs[key] ||= []
      @logs[key] << value
    end
    
    def to_s
      @logs.collect do |key, values|
        value = values.collect {|v| v.to_s.center(5) }.join("|")
        "#{key.to_s} = #{value} "
      end.join("\n")
    end
  end

  class Context
    def initialize
      @stringio = StringIO.new

      @logger = Logger.new(@stringio)
      @logger.formatter = proc { |severity, datetime, progname, msg| "#{msg}\n" }

      @log_collectors = []
    end
    
    def log_assign(name, value)
      if @log_collectors.size > 0
        @log_collectors.last.append name, value
      else
        @logger.info "#{name} = #{value}"
      end
      return value
    end

    def loop_begin
      @log_collectors.push LogCollector.new
    end

    def loop_inside_begin
    end

    def loop_inside_end
    end

    def loop_end
      collector = @log_collectors.pop
      @logger.info collector.to_s
    end
    
    def to_s
      @stringio.string
    end
    
  end
end