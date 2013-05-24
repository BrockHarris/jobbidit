class Pastwork < ActiveRecord::Base
  attr_accessible :user_id, :title, :content, :photo

  belongs_to :user
  has_attached_file :photo,
                    :styles => {
                    :square=> "200x200#",
                    :rectangle  => "240x200#" },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "/:style/:id/:filename" 
end
