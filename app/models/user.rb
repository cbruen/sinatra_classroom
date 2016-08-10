
class User < ActiveRecord::Base
	
	has_secure_password
	
	validates_presence_of :username, message: "Username required!"
	validates_presence_of :email, message: "Email cannot be blank!"
	validates_presence_of :password_digest, message: "Please fill in password field!"
	
	has_many :tests, :foreign_key => 'student_id'
	has_many :questions
	has_many :answers, :class_name => 'Question', through: :tests
	
end