module Instant
  module Sinatra
    class App < ::Sinatra::Base
      set :public, File.expand_path(File.join(File.dirname(__FILE__), "../../../public"))
      set :views, File.expand_path(File.join(File.dirname(__FILE__), "../../../views"))
      
      get '/' do
        erb :index
      end
    end
  end
end