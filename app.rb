require 'sinatra'
require 'sinatra/activerecord'
require 'require_all'

require_relative 'config/environments'

require_all 'mailers'
require_all 'models'