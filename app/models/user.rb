
class User < ActiveRecord::Base
	
	has_secure_password
	
	has_many :tests, :foreign_key => 'student_id'
	has_many :questions
	has_many :answers, :class_name => 'Question', through: :tests
	
end