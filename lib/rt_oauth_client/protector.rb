require 'rt_oauth_client'
require 'rt_oauth_client/bearer_token'
require 'rt_oauth_client/param_token'
require 'rt_oauth_client/authorizer'
module RtOauthClient
  module Protector
    extend ActiveSupport::Concern
    included do
      include RtOauthClient::Authorizer
      include RtOauthClient::ParamToken
      include RtOauthClient::BearerToken
    end
    
    helper_method :protected_user

    protected
    
    def protect!
      fetch_user_from_oauth2 # load user from request headers
      
      unless protected_user
        if respond_to?(:protect_failure)
          protect_failure
        else
          head 403
        end
      end
    end
    alias_method :protect_with_user!, :protect!
    
    def fetch_user_from_oauth2
      if protected_user.nil?
        RtOauthClient.configuration.authentication_methods.each do |m|
          token = send("find_#{m}")
          next unless token
          set_bearer_token(token)
          if me
            @protected_user = me
            break
          end
        end
      end
      protected_user
    end
    
    def protected_user
      @protected_user
    end
    
  end
end
