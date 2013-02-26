class Bid < ActiveRecord::Base
  attr_accessible :user_id, :job_id, :amount
  belongs_to :job
  belongs_to :user
end
