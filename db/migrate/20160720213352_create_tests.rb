class CreateTests < ActiveRecord::Migration
  def change
  	create_table :tests do |t|
  		t.integer :answer_id
  		t.integer :student_id
  	end
  end
end
