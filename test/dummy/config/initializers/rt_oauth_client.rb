RtOauthClient.configure do |config|
  config.authentication_methods = [:bearer_token]
  config.token_name             = 'access_token'
  config.oauth_token_name       = 'access_token'
  config.client_id              = 'a0f788c8f081c343a889af3d6473652895e871f34a8ac17a29dd036b7b2919af'
  config.client_secret          = 'd151e9f60d555bcfb429232751565266438422839c3532d84c41d7d61f20152a'
  config.bearer_token_regex     = /Bearer /i
  # config.oauth_uri              = 'http://localhost:3000/api/v1/me.json'
end
