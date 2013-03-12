class Bid < ActiveRecord::Base
  attr_accessible :user_id, :job_id, :amount
  belongs_to :job
  belongs_to :user

  validates :amount, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than => 1}

  after_save :update_current_job_bid

  def update_current_job_bid
    self.job.update_current_bid
    current_bid = self.amount
    connection.execute("UPDATE jobs SET current_bid = #{current_bid} WHERE id = #{self.job.id}")
  end
end
