Rails.application.routes.draw do
  post '/' => 'memes#generate'

  get '/list' => 'memes#list'
end
