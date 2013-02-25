class Authentication < ActiveRecord::Base
	attr_accessible :user_id, :provider, :token, :uid
  belongs_to :user
end
