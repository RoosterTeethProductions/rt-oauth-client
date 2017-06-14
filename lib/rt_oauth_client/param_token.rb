module RtOauthClient
  module ParamToken
    extend ActiveSupport::Concern
    included do
    end
    def find_param_token
      request.params[RtOauthClient.configuration.token_name]
    end
  end
end
