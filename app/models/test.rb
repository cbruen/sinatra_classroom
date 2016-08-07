
class Test < ActiveRecord::Base
	
	belongs_to :answer, :class_name => 'Question'
	belongs_to :student, :class_name => 'User'
	
end