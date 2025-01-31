require './config/environment'

class ApplicationController < Sinatra::Base

  enable :sessions 
  set :session_secret, "9406069"

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    erb :index 
  end

  helpers do 
    def logged_in?
      !!current_user
    end

    def current_user 
      @user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end

end
