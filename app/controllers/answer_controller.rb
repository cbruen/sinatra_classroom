require './config/environment'

class AnswerController < ApplicationController
	
  configure do
    set :public_folder, 'public'
    set :views, 'app/views/'
  end
	

	get '/answers' do
		if signed_in?
			@user = User.find(session[:id])
			@questions  = Question.all - @user.questions - @user.answers
			erb :'/answers/index'
		else
			redirect '/login'
		end
	end
	
	get '/answers/:id' do
		if signed_in?
			@user = User.find(session[:id])
			@answer = Question.find(params[:id])
			erb :'/answers/show'
		else
			redirect '/login'
		end
	end
	
	post '/answers/:id' do
		if signed_in?
			@user = User.find(session[:id])
			@answer = Question.find(params[:id])
			if @answer.answer == params[:answer] && !@user.answers.include?(@answer)
				@user.answers << @answer
				redirect '/account'
			else
				@result = params[:answer]
				erb :'/answers/show'
			end
		else
			redirect '/login'
		end
	end	
			
	
end