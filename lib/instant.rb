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
      if node.class == Sexp
        if node[0] == :lasgn
          puts "lasgn: #{node}"
          s << replace_lasgn(node)
        else
          s << process_sexp(node)
        end
      else
        s << node
      end
      s
    end
  end
  
  # watcg for :dasgn
  def replace_dasgn(node)
  end

  # watch for :lasgn
  def replace_lasgn(node)
    name = node[1]
    expr = node[2]
    s(:lasgn,
        name,
        s(:call, nil, :LogObject, s(:arglist, s(:lit, name), expr)))
  end

  # watch for :masgn  

end