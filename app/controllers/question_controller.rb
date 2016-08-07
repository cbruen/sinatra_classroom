require './config/environment'
require 'pry'
class QuestionController < ApplicationController
	
  configure do
    set :public_folder, 'public'
    set :views, 'app/views/'
  end
	

	get '/questions/new' do
		if signed_in?
			erb :'/questions/new'
		else
			redirect '/login'
		end
	end
	
	
	post '/questions' do
		
		if  !params[:answer].empty?
			@user = User.find(session[:id])
			@user.questions << Question.create(description: params[:description], answer: params[:answer], name: params[:name])
			redirect '/account'
		else
			redirect '/questions/new'
		end
	end
	
	get '/questions/:id' do
		if signed_in?
			@question = Question.find(params[:id])
			erb :'/questions/show'
		else
			redirect '/login'
		end
	end
	
	get '/questions/:id/edit' do
		if signed_in?
			@question = Question.find(session[:id])
			erb :'/questions/edit'
		else
			redirect '/login'
		end
		
	end
	
	patch '/questions/:id' do
		@question = Question.find(session[:id])
		if signed_in? && !params[:content].empty?	
				@question.update(content: params[:content])
				redirect "/questions/#{@question.id}"
		elsif signed_in? && params[:content].empty?
				redirect "/questions/#{@question.id}/edit"
		else
			redirect '/login'
		end		
	end
	
	
	delete '/questions/:id' do
		if signed_in?
			@question = Question.find(session[:id])
			@question.destroy
		else
			redirect '/login'
		end
	end
	
	
end