require 'rubygems'
require 'bundler'
Bundler.require :default, :production

$LOAD_PATH << "lib"
require 'instant'
require 'instant/sinatra/app'

run Instant::Sinatra::App