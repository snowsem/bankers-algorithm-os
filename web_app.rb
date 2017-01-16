require 'sinatra'
require 'sinatra/flash'
require './process.rb'

enable :sessions


get "/" do
  erb :index
end

post "/generate" do
  erb :generate
end

post "/matrix" do
  @resurs_array = params[:resurs_array]
  erb :matrix
end

post "/check" do
  @res = func(params[:resurs].to_i, params[:process].to_i, params[:resurs_a].to_a, params[:process_array] )
  erb :result
end