require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "admissions_advice_app"
  end

  get "/" do
    erb :welcome
  end

end
