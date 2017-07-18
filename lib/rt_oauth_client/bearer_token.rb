module RtOauthClient
  module BearerToken
    extend ActiveSupport::Concern
    included do
    end

    def find_bearer_token
      headers['HTTP_AUTHORIZATION'].match(RtOauthClient.configuration.bearer_token_regex) && headers['HTTP_AUTHORIZATION'].split(/bearer/i).last.gsub(/\s/,'')
    end
  end
end
