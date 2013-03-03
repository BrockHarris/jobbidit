class Page < ActiveRecord::Base
  attr_accessible :name, :header, :content

  validates :header, :presence => true
  validates :content, :presence => true
end
