class Job < ActiveRecord::Base

  searchable do
    text :title, :description, :category
  end

  #after_save :set_job_location ##IP##

  attr_accessible :title, :description, :user_id, :category, :current_bid, :duration, :expire_date, :open, :photo, 
                  :jobphotos_attributes, :bid_count, :start_date, :location

  belongs_to :user
  belongs_to :jobtype

  has_many :bids, :dependent => :destroy
  has_many :jobphotos, :dependent => :destroy
  has_many :pmessages, :dependent => :destroy
  
  accepts_nested_attributes_for :jobphotos, :allow_destroy => true

  validates :title, :presence => true
  validates :description, :presence => true, :length => { :maximum => 500 }
  validates :user_id, :presence => true

  def update_current_bid
    bid_count = self.bids.count
    connection.execute("UPDATE jobs SET bid_count = #{bid_count} WHERE id = #{self.id}")
  end

  #def set_job_location ###### IP #####
    #self.job.update_current_bid
    #current_bid = self.amount
    #connection.execute("UPDATE jobs SET current_bid = #{current_bid} WHERE id = #{self.job.id}")
  #end
end  