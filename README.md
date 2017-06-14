# RtOauthClient

Provides authorization by services back to the RT Oauth service


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'rt_oauth_client'
```

And then execute:
```bash
$ bundle
```

# Usage

## Configuration

```ruby
RtOauthClient.configure do |config|
  # all available authentication methods
  config.authentication_methods = [:cookie_auth, :param_token, :bearer_token]
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
  config.bearer_token_regex     = /Bearer /i
  # the OAUTH URL to get user info from
  config.oauth_url              = 'http://localhost:3200/api/v1/me.json'
end

```

## Protecting a controller

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

## TODO

1. Cache common calls to remote
1. Create rake tasks for install 

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
