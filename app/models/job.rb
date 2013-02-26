class Job < ActiveRecord::Base
  attr_accessible :title, :description, :user_id, :category, :current_bid, :duration, :expire_date, :open

  belongs_to :user
  #has_many :bids

  validates :title, :presence => true
  validates :description, :presence => true, :length => { :maximum => 500 }
  validates :user_id, :presence => true
end
