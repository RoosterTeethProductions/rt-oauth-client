Rt::Oauth::Client.configure do |config|
  config.authentication_methods = [:cookie_auth, :param_token, :bearer_token]
  config.cookie_name            = 'access_token'
  config.token_name             = 'access_token'
  config.oauth_token_name       = 'access_token'
  config.client_id              = 'a0f788c8f081c343a889af3d6473652895e871f34a8ac17a29dd036b7b2919af'
  config.client_secret          = ''
  config.bearer_token_regex     = /Bearer /i
  config.oauth_url              = 'http://localhost:3200/api/v1/me.json'
end
