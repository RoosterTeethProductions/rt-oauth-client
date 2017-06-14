require 'rt_oauth_client'
require 'rt_oauth_client/bearer_token'
require 'rt_oauth_client/cookie_auth'
require 'rt_oauth_client/param_token'
require 'rt_oauth_client/authorizer'
module RtOauthClient
  module Protector
    extend ActiveSupport::Concern
    included do
      include RtOauthClient::Authorizer
      include RtOauthClient::CookieAuth
      include RtOauthClient::ParamToken
      include RtOauthClient::BearerToken
      before_action :protect!
    end

    def protect!
      return @ok if @ok
      @ok = nil
      RtOauthClient.configuration.authentication_methods.each do |m|
        token = send("find_#{m}")
        next unless token
        if authorize!(token).success?
          @ok = true
          break
        end
      end
      unless @ok
        head 403
      end
    end

  end
end
