class Job < ActiveRecord::Base
  attr_accessible :title, :description, :user_id, :category, :current_bid, :duration, :expire_date, :open, :photo, :jobphotos_attributes

  belongs_to :user
  belongs_to :jobtype

  has_many :bids, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :jobphotos, :dependent => :destroy
  
  accepts_nested_attributes_for :jobphotos, :allow_destroy => true

  validates :title, :presence => true
  validates :description, :presence => true, :length => { :maximum => 500 }
  validates :user_id, :presence => true

end  