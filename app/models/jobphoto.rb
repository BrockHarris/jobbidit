class Jobphoto < ActiveRecord::Base
  attr_accessible :job_id, :caption, :photo
  belongs_to :job
  
  has_attached_file :photo,
                    :styles => {
                    :thumb => "25x25#",
                    :small=> "50x50#",
                    :large  => "250x330#",
                    :full  => "500x500" },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "/:style/:id/:filename" 
end
