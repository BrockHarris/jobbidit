class Pmessage < ActiveRecord::Base
  attr_accessible :user_id, :receiver_id, :title, :body, :deleted_at, :read, :job_id

  belongs_to :job
  belongs_to :user
  belongs_to :receiving_user, :class_name=>"User", :foreign_key=>"receiver_id" 
end
