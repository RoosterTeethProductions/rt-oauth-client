require 'rt_oauth_client'
require 'rt_oauth_client/bearer_token'
require 'rt_oauth_client/param_token'
require 'rt_oauth_client/authorizer'
module RtOauthClient
  module Protector

    class ScopesError < StandardError

    end
    extend ActiveSupport::Concern
    included do
      include RtOauthClient::Authorizer
      include RtOauthClient::ParamToken
      include RtOauthClient::BearerToken
      include RtOauthClient::RequestHelper

      helper_method(:protected_user) if respond_to?(:protected_user, true)
    end

    protected

    def rt_auth_authorize!(*scopes)
      protect!
      @_rt_auth_scopes = scopes.presence || RtOauthClient.configuration.default_scopes

      unless valid_rt_auth_token?
        rt_auth_scopes_error
      end
    end

    def valid_rt_auth_token?
      token_info && (token_info["expires_in_seconds"] > 0 rescue false) && match_scope?(token_info)
    end

    def match_scope?(token_info)
      @_rt_auth_scopes.blank? || @_rt_auth_scopes.any?{|s| (token_info["scopes"] || []).include?(s.to_s) }
    end

    def rt_auth_scopes_error
      raise ScopesError, "Permissions #{@_rt_auth_scopes.join(', ')} are required."
    end

    def protect!
      fetch_user_from_oauth2 # load user from request headers

      unless protected_user
        #Define protect_failure to return custom response
        if respond_to?(:protect_failure, true) # check protected and private methods too
          protect_failure
        else
          render inline: 'you need sign in to continue', status: 401
        end
      end
    end
    alias_method :protect_with_user!, :protect!

    def fetch_user_from_oauth2
      if @protected_user.nil?
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
      @protected_user
    end
    alias_method :protect_with_user, :fetch_user_from_oauth2

    #msut call fetch_user_from_oauth2, then #protected_user
    def protected_user
      @protected_user
    end
  end
end
