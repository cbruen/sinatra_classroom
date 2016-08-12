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
			current_user
			@questions = @current_user.questions
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
		@user = User.new(params])
  		if @user.save
  			session[:id] = @user.id
  			redirect '/account'
  		else
  			erb :signup
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
   	   	if params[:username].empty?
   	   		@user = User.new
   	   		@user.errors[:username] = "Name required."
   	   	else
   	    	@user = User.find_by(username: params[:username])
   	  	  	@user ||= User.new
  			if @user.username.nil?
				@user.errors[:username] = "Name not found."  		
  			elsif @user.authenticate(params[:password])
  				session[:id] = @user.id
    			redirect '/account'
    			return
    		else
    		@user.errors[:email] = "Wrong email or password. Try again."
    		end
    	end
    	erb :login
  end
  
  get '/logout' do
  	if signed_in?
  		session.clear
  		redirect '/'
  	else
  		redirect '/'
  	end
  end
  

  helpers do
  	
  	def current_user
  		@current_user ||= User.find(session[:id])
  	end
  	
  	def signed_in?
		!!session[:id]
	end
  	

  	
  end
 	
 	
  
end
