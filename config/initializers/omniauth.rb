Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2 , ENV['G_CLIENT_ID'], ENV['G_CLIENT_SEC']
end
OmniAuth.config.allowed_request_methods = %i[post]