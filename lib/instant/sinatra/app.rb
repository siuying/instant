require 'json'

module Instant
  module Sinatra
    class App < ::Sinatra::Base
      set :public, File.expand_path(File.join(File.dirname(__FILE__), "../../../public"))
      set :views, File.expand_path(File.join(File.dirname(__FILE__), "../../../views"))

      get '/' do
        erb :index
      end
      
      post '/compile' do
        content_type :json
        source = params[:source]

        puts "source:" + source
        if source && source.strip != ""
          result = Instant::Runner.new.run(source.strip)
          result.to_json
        else
          {:status => :ok, :result => ""}.to_json
        end
      end
    end
  end
end