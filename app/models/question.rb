
class Question < ActiveRecord::Base
	
	belongs_to :user
	has_many :tests, :foreign_key => :answer_id
	has_many :students, :class_name => 'User', through: :tests
	
	
end