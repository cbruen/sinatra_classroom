require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end
 
 	get '/' do
 		erb :home
 	end
 	
 	
 	get '/account' do
		if signed_in?
			@user=User.find(session[:id])
			@questions = @user.questions
			@answers = @user.answers
			erb :index
		else
			redirect '/login'
		end
	end
	
 	
  get '/signup' do
  		erb :signup
  end
  
  post '/signup' do

  		if Helpers.valid_submission(params)
  			 @user = User.create(username: params[:username], email: params[:email], password: params[:password])
  			session[:id] = @user.id
  			redirect '/account'
  		else
  			redirect '/signup'
  		end
  	
  end


  get '/login' do
    if !signed_in?
       erb :login
	else
		redirect '/account'
	end
  end
  
  post '/login' do
    @user = User.find_by(username: params[:username])
  		if @user.authenticate(params[:password])
  			session[:id] = @user.id
    		redirect '/account'
    	else
    		erb :login
    	end
  end
  
  get '/logout' do
  	if signed_in?
  		session.clear
  		redirect '/login'
  	else
  		redirect '/'
  	end
  end
  

  helpers do
  	def signed_in?
		!!session[:id]
	end
  	

  	
  end
 	
 	
  
end
