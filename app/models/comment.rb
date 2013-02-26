class Comment < ActiveRecord::Base
 attr_accessible :user_id, :job_id, :content
  belongs_to :job
  belongs_to :user
end
