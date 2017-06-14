module RtOauthClient
  module CookieAuth
    extend ActiveSupport::Concern
    included do
    end

    def find_cookie_auth
      request.cookies[RtOauthClient.configuration.cookie_name]
    end

  end
end
