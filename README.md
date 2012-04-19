# Instant

An experiment on real time visualize development tool, inspired by
[Bret Victor's Inventing on Principle](http://vimeo.com/36579366) 
talk and [@ermau  C# Implementation](https://github.com/ermau/Instant).

## Install as gem

    gem install instant
    
    require 'instant'
    
    runner = Instant::Runner.new
    runner.run "def hello(a); a = 10 + a; end; hello(20)"

## Run a demo

![](http://f.cl.ly/items/0m2o252A3n1C032R2s0X/%E8%9E%A2%E5%B9%95%E5%BF%AB%E7%85%A7%202012-04-19%20%E4%B8%8A%E5%8D%8812.23.58.png)

You can run it live at [instant-ruby.herokuapp.com](http://instant-ruby.herokuapp.com).

## Run locally

First clone the source code from [github.com/siuying/instant](https://github.com/siuying/instant).

In the app folder, run following commands:

    bundle install
    foreman start
    
then open your browser at http://127.0.0.1:5000/

## Credits

- [Bret Victor's Inventing on Principle](http://vimeo.com/36579366) - this talk is just eyes opening!
- [Instant (C#)](https://github.com/ermau/Instant) @ermau's C# implementation motivate me to create this Ruby port
- [ACE](http://ace.ajax.org/) - Really cool AJAX based IDE
- [RubyParser](https://github.com/seattlerb/ruby_parser) and [Ruby2Ruby](https://github.com/seattlerb/ruby2ruby) - created by Seattle.rb, they make this app possible

## Contact

[@siuying](http://twitter.com/siuying)
