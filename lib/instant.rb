class Instant
  attr_reader :source, :processed
  
  def initialize(source)
    self.source = source
    @parser    = RubyParser.new
    @generator = Ruby2Ruby.new
  end
  
  def source=(source)
    @source = source
    @generated = self.parse(source)
    @source
  end
  
  def parse(source)
    sexp = @parser.process(source)
    
    # TODO process
    
    @generator.process(sexp)
  end

end