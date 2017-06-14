module RtOauthClient
  module BearerToken
    extend ActiveSupport::Concern
    included do
    end

    def find_bearer_token
      request.headers.find do |key, value|
        value if key.match(RtOauthClient.configuration.bearer_token_regex)
      end
    end
  end
end
