Rails.application.routes.draw do
  post '/' => 'memes#generate'
end
