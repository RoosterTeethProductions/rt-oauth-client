# RtOauthClient

Provides authorization by services back to the RT Oauth service


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'rt-oauth-client'
```

And then execute:
```bash
$ bundle
```

# Usage

## Configuration

Put the following in `$app_root/config/initializers/rt_oauth_client.rb`

```ruby
RtOauthClient.configure do |config|
  # all available authentication methods
  # param_token allows the params[:param_token] to be sent to the oauth server
  # bearer_token allows for `headers[:bearer_token]` to be parsed and sent to the oauth server
  config.authentication_methods = [:bearer_token, :param_token]
  # Named cookie to look for
  config.cookie_name            = 'access_token'
  # Named token via param
  config.token_name             = 'access_token'
  # oauth token name
  config.oauth_token_name       = 'access_token'
  # client ID to use
  config.client_id              = 'a0f788c8f081c343a889af3d6473652895e871f34a8ac17a29dd036b7b2919af'
  # client secret
  config.client_secret          = ''
  # bearer regex - looked for in headers
  # Probably dont want to change this
  config.bearer_token_regex     = /Bearer /i
  # the OAUTH URL to get user info from
  config.oauth_url              = 'https://auth.staging.roosterteeth.com'
end

```

## Protecting a controller

When the below is implemented, `#protected_user` (User) Hash will become available, similar to devise and `#current_user`
The internals of the `#protected_user` hash will be the return from [rt-oauth2 response](https://github.com/RoosterTeethProductions/rt-oauth2#response)

Adding `include RtOauthClient::Protector` to a controller will protect that controller with `#protect!` method

If you want to skip this for an action, add: `skip_before_action :protect!, actions: [:create]` or whatever

```
class SomeController < ApplicationController
  include RtOauthClient::Protector
end
```

Or inherit from the main controller to inherit the `#protect!` method

```ruby 
class SomeController < RtOauthClient::ApplicationController
end

```

## Response if a user is found by the `#protect!` method

Response is generated from [rt-oauth2](https://github.com/RoosterTeethProductions/rt-oauth2#response)

## TODO

1. Cache common calls to remote
1. Create rake tasks for install 

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
