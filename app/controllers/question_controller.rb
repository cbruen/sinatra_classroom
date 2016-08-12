require './config/environment'
require 'pry'
class QuestionController < ApplicationController
	
  configure do
    set :public_folder, 'public'
    set :views, 'app/views/'
  end
	
	get '/questions' do
		if signed_in?
			@user = User.find(session[:id])
			erb :'/questions/index'
		else
			redirect '/login'
		end
	end

	get '/questions/new' do
		if signed_in?
			erb :'/questions/new'
		else
			redirect '/login'
		end
	end
	
	
	post '/questions' do
		
		if  !params[:answer].empty? && !params[:name].empty? && !params[:description].empty?
			@user = User.find(session[:id])
			@user.questions.create(description: params[:description], answer: params[:answer], name: params[:name])
			redirect '/account'
		else
			redirect '/questions/new'
		end
	end
	
	get '/questions/:id' do
		if signed_in?
			@user = User.find(session[:id])
			@question = Question.find(params[:id])
			if @question.user == @user
				return erb :'/questions/show'
			end
		end
		redirect '/account'
	end
	
	get '/questions/:id/edit' do
		if signed_in?
			@user = User.find(session[:id])
			@question = Question.find(params[:id])
			if @user.questions.include?(@question)
				erb :'/questions/edit'
			else
				redirect '/account'
			end
		else
			redirect '/login'
		end
		
	end
	
	patch '/questions/:id' do
		@user = User.find_by(id: session[:id])
		@question = Question.find(params[:id])
		if signed_in?  && @user == @question.user && !params[:answer].empty? && !params[:name].empty? && !params[:description].empty?
			@question.update(description: params[:description], answer: params[:answer], name: params[:name])
			redirect "/account"
		elsif signed_in? && (params[:answer].empty? || params[:name].empty? || params[:description].empty?)
			redirect "/questions/#{@question.id}/edit"
		else
			redirect '/login'
		end		
	end
	
	
	delete '/questions/:id' do
		if signed_in?
			@question = Question.find(params[:id])
			@user = User.find(session[:id])
			if @question.user == @user
				@question.destroy
			end
		end
			redirect '/account'
	end
	
	
end