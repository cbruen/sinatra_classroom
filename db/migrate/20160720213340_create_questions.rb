class CreateQuestions < ActiveRecord::Migration
  def change
  	create_table :questions do |t|
  		t.string :name
  		t.string :description
  		t.string :answer
  		t.integer :user_id
	end
  end
end
