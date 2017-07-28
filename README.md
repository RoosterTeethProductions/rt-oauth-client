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
  config.client_id              = ''
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

Add `include RtOauthClient::Protector` to a controller

add `before_action protect_with_user!` to halt with 403 if a user is not found

add `before_action protect_with_user` _not_ to halt with 403

```
class SomeController < ApplicationController
  include RtOauthClient::Protector
end
```

## Response

> All authorization responses should have the formats below.  If it does not, its a bug, report it. 

_Private Response_

```json
{
  "id":"05ec30d2-d98c-4986-8eb1-9c2c0f49278e",
  "type":"user",
  "attributes":{
    "uuid":"05ec30d2-d98c-4986-8eb1-9c2c0f49278e",
    "created_at":"2017-07-17T04:24:28.000Z",
    "username":"a_user",
    "display_title":null,
    "pictures":{
      "tb":{
        "profile":"https://s3.amazonaws.com/cdn.roosterteeth.com/default/tb/user_profile_female.jpg",
        "cover":"https://s3.amazonaws.com/cdn.roosterteeth.com/default/tb/generic_rt_cover.jpg"
      },
      "sm":{
        "profile":"https://s3.amazonaws.com/cdn.roosterteeth.com/default/sm/user_profile_female.jpg",
        "cover":"https://s3.amazonaws.com/cdn.roosterteeth.com/default/sm/generic_rt_cover.jpg"
      },
      "md":{
        "profile":"https://s3.amazonaws.com/cdn.roosterteeth.com/default/md/user_profile_female.jpg",
        "cover":"https://s3.amazonaws.com/cdn.roosterteeth.com/default/md/generic_rt_cover.jpg"
      },
      "original":{
        "profile":"https://s3.amazonaws.com/cdn.roosterteeth.com/default/original/user_profile_female.jpg",
        "cover":"https://s3.amazonaws.com/cdn.roosterteeth.com/default/original/generic_rt_cover.jpg"
      }
    },
    "last_login_at":0,
    "member_tier":"double_gold",
    "member_tier_i":5,
    "location":{
      "timezone":"America/Chicago",
      "store_region":"INTL",
      "ipaddress":"::1"
    },
    "email":"me@this.com",
    "db_id":5795,
    "roles":[
      "admin",
      "cast_and_crew_admin"
    ],
    "birthday":"1997-07-17",
    "sex":null,
    "sponsorship_details":{
      "sponsorship_starts_at":null,
      "sponsorship_ends_at":null,
      "sponsorship_type":null,
      "double_gold_ends_at":null
    }
  },
  "global_login_token":"5795:cozauYtGe7Yqv6ASn2Y2",
  "meta":{
    "id":1,
    "full_name":"A User",
    "address1":"101 Danny Way",
    "address2":"none",
    "city":"Austin",
    "state_province":"TX",
    "country":"US",
    "zip_postal":"78741",
    "shirt_size":"M",
    "status":"current",
    "shipping_cost":0.0,
    "created_by":5795,
    "updated_by":5795,
    "deleted_by":null,
    "last_bill_date":null,
    "created_at":"2017-07-28T23:15:40.000Z",
    "updated_at":"2017-07-28T23:15:40.000Z",
    "deleted_at":null
  }
}
```

_Public Response_

```json
{
  "id":"05ec30d2-d98c-4986-8eb1-9c2c0f49278e",
  "type":"user",
  "attributes":{
    "uuid":"05ec30d2-d98c-4986-8eb1-9c2c0f49278e",
    "created_at":"2017-07-17T04:24:28.000Z",
    "username":"a_user",
    "display_title":null,
    "pictures":{
      "tb":{
        "profile":"https://s3.amazonaws.com/cdn.roosterteeth.com/default/tb/user_profile_female.jpg",
        "cover":"https://s3.amazonaws.com/cdn.roosterteeth.com/default/tb/generic_rt_cover.jpg"
      },
      "sm":{
        "profile":"https://s3.amazonaws.com/cdn.roosterteeth.com/default/sm/user_profile_female.jpg",
        "cover":"https://s3.amazonaws.com/cdn.roosterteeth.com/default/sm/generic_rt_cover.jpg"
      },
      "md":{
        "profile":"https://s3.amazonaws.com/cdn.roosterteeth.com/default/md/user_profile_female.jpg",
        "cover":"https://s3.amazonaws.com/cdn.roosterteeth.com/default/md/generic_rt_cover.jpg"
      },
      "original":{
        "profile":"https://s3.amazonaws.com/cdn.roosterteeth.com/default/original/user_profile_female.jpg",
        "cover":"https://s3.amazonaws.com/cdn.roosterteeth.com/default/original/generic_rt_cover.jpg"
      }
    },
    "last_login_at":0,
    "member_tier":"double_gold",
    "member_tier_i":5,
    "location":{
      "timezone":"America/Chicago",
      "store_region":"INTL"
    }
  }
}
```


## TODO

1. Cache common calls to remote
1. Create rake tasks for install 

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
