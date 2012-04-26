# Instant

An experiment on real time visualize development tool, inspired by
[Bret Victor's Inventing on Principle](http://vimeo.com/36579366) 
talk and [@ermau  C# Implementation](https://github.com/ermau/Instant).

## Run a demo

![](http://f.cl.ly/items/0m2o252A3n1C032R2s0X/%E8%9E%A2%E5%B9%95%E5%BF%AB%E7%85%A7%202012-04-19%20%E4%B8%8A%E5%8D%8812.23.58.png)

1. Install Ruby 1.9.3
2. Clone the source code from [github.com/siuying/instant](https://github.com/siuying/instant).
3. In the app folder, run following commands:

    bundle install
    foreman start
  
4. open your browser at http://127.0.0.1:5000/

## Install as gem

Install the Gem:

    gem install instant
    
Then in your program:
    
    require 'rubygems'
    require 'instant'
    
    runner = Instant::Runner.new
    runner.run "def hello(a); a = 10 + a; end; hello(20)"

## Credits

- [Bret Victor's Inventing on Principle](http://vimeo.com/36579366) - this talk is just eyes opening!
- [Instant (C#)](https://github.com/ermau/Instant) @ermau's C# implementation motivate me to create this Ruby port
- [ACE](http://ace.ajax.org/) - Really cool AJAX based IDE
- [RubyParser](https://github.com/seattlerb/ruby_parser) and [Ruby2Ruby](https://github.com/seattlerb/ruby2ruby) - created by Seattle.rb, they make this app possible

## Contact

[@siuying](http://twitter.com/siuying)
