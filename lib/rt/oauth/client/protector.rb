require 'rt/oauth/client/authorizer'
require 'rt/oauth/client/param_token'
require 'rt/oauth/client/cookie_auth'
require 'rt/oauth/client/bearer_token'
module Rt::Oauth::Client
  module Protector
    extend ActiveSupport::Concern
    included do
      include Authorizer
      include CookieAuth
      include ParamToken
      include BearerToken
      before_action :protect!
    end

    def protect!
      puts 'protecting'
      return @ok if @ok
      @ok = nil
      Rt::Oauth::Client.configuration.authentication_methods.each do |m|
        token = send("find_#{m}")
        next unless token
        if authorize!(token).success?
          puts "Successful, returning"
          @ok = true
          break
        else
          puts "unsuccessful with token '#{token}'"
        end
      end
      unless @ok
        head 403
      end
    end

  end
end
