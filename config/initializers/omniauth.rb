Rails.application.config.middleware.use OmniAuth::Builder do
	if Rails.env.production?
		provider :facebook, '262583950478296', '21aee614fa6cef256a437015b75dc6fa' 
	elsif Rails.env.development?
    provider :facebook, '307924885975931', '9693545f7c41ff6ea601e58ebbe232e3' 
  else  
  	provider :facebook, '262583950478296', '21aee614fa6cef256a437015b75dc6fa' 
  end
end