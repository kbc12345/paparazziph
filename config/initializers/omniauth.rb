Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["fb_app_id"], ENV["fb_secret"], {:scope => "public_profile, user_photos, pages_manage_cta, manage_pages"}
end