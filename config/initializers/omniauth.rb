Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['APP_ID'], ENV['APP_SECRET'],
  provider_ignores_state: true
end
