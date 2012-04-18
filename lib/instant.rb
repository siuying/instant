class Instant
  attr_reader :source, :processed

  def initialize(source="")
    @parser    = RubyParser.new
    @generator = Ruby2Ruby.new
    self.source = source
  end
  
  def source=(source)
    @source = source
    @processed = self.process(source)
    @source
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
        s(:call, nil, :LogAssign, s(:arglist, s(:lit, name), process_sexp(expr))))
  end

  # watch for :masgn  

end