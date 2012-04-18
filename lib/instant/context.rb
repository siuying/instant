require 'logger'
require 'stringio'

module Instant
  class LoopTooDeepError < StandardError; end

  class LogCollector
    def initialize(keys=[])
      @logs = {}
      keys.each {|k| @logs[k] = [] } if keys
    end
    
    def append(key, value)
      @logs[key] ||= []
      @logs[key] << value
    end

    def fill_empty
      max_length = @logs.values.collect{|v| v.length}.max
      fill_keys  = @logs.keys.select {|k| @logs[k].length < max_length }
      fill_keys.each do |key|
        @logs[key] << ""
      end
    end
    
    def to_s
      @logs.collect do |key, values|
        value = values.collect {|v| v.to_s.center(5) }.join("|")
        "#{key.to_s.ljust(8)} = #{value} "
      end.join("\n")
    end
  end

  class Context
    def initialize
      @stringio = StringIO.new
      @assigns = Set.new
      @loop_counter = 0
      @logger = Logger.new(@stringio)
      @logger.formatter = proc { |severity, datetime, progname, msg| "#{msg}\n" }

      @log_collectors = []
      @loop_counter   = 0
    end
    
    def log_assign(name, value)
      if @log_collectors.size > 0
        @log_collectors.last.append name, value
      else
        @assigns << name
        @logger.info "#{name.to_s.ljust(8)} = #{value.to_s.center(5)}"
      end
      return value
    end

    def loop_begin
      @log_collectors.push LogCollector.new(@assigns)
    end

    def loop_inside_begin
    end

    def loop_inside_end
      @log_collectors.last.fill_empty
      @loop_counter = @loop_counter + 1

      if @loop_counter > 1000
        self.loop_end
        raise ::Instant::LoopTooDeepError.new("Loop too much")
      end
    end

    def loop_end
      collector = @log_collectors.pop
      @logger.info collector.to_s
    end
    
    def close
      while collector = @log_collectors.pop
        @logger.info collector.to_s
      end
    end
    
    def to_s
      @stringio.string
    end
    
  end
end