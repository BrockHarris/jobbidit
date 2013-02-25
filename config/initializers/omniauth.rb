Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '262583950478296', '21aee614fa6cef256a437015b75dc6fa' 
end