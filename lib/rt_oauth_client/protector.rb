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
      before_action :protect!
    end

    def protect!
      return @protected_user if @protected_user
      @protected_user = nil
      RtOauthClient.configuration.authentication_methods.each do |m|
        token = send("find_#{m}")
        next unless token
        set_bearer_token(token)
        if me
          @protected_user = me
          break
        end
      end
      unless @protected_user
        head 403
      end
      @protected_user
    end

    def protected_user
      @protected_user
    end

  end
end
