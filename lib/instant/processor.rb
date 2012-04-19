require 'ruby_parser'
require 'ruby2ruby'

module Instant
  class Processor
    def initialize
      @parser    = RubyParser.new
      @generator = Ruby2Ruby.new
    end

    def process(source)
      sexp = @parser.process(source)    
      sexp = process_sexp(sexp)    
      @generator.process(sexp)
    end
  
    private
    def process_sexp(sexp)
      sexp.inject(s()) do |s, node|
        case node
        when Sexp
          name = node[0]
          case name
          when :lasgn
            s << log_lasgn(node)
          when :while
            s << s(:call, nil, :loop_begin, s(:arglist))
            s << log_while(node)
            s << s(:call, nil, :loop_end, s(:arglist))
          else
            s << process_sexp(node)
          end
        else
          s << node
        end
        s
      end
    end

    # watch for :lasgn
    def log_lasgn(node)
      name = node[1]
      expr = node[2]
      s(:lasgn,
          name,
          s(:call, nil, :log_assign, s(:arglist, s(:lit, name), process_sexp(expr))))
    end
  
    # watch for :while
    def log_while(node)
      s(:while,
       process_sexp(node[1]),
       s(:block,
        s(:call, nil, :loop_inside_begin, s(:arglist)),
        process_sexp(node[2]),
        s(:call, nil, :loop_inside_end, s(:arglist))),
       true)
    end

    # watch for :masgn  

  end
end