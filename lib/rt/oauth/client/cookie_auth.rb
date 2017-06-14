require "rt/oauth/client/authorizer"

module Rt::Oauth::Client
  module CookieAuth
    extend ActiveSupport::Concern
    included do
    end

    def find_cookie_auth
      request.cookies[Rt::Oauth::Client.configuration.cookie_name]
    end

  end
end
