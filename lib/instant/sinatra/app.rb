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
          begin
            result = Instant::Runner.new.run(source.strip)
            result.merge({:status => :ok}).to_json
          rescue Racc::ParseError => e
            {:status => :error, :message => e.message }.to_json
          rescue Instant::LoopTooDeepError => e
            {:status => :error, :message => e.message }.to_json
          end
        else
          {:status => :ok, :result => ""}.to_json
        end
      end
    end
  end
end