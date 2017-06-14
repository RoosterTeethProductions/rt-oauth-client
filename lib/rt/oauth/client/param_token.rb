module Rt::Oauth::Client
  module ParamToken
    extend ActiveSupport::Concern
    included do
    end
    def find_param_token
      request.params[Rt::Oauth::Client.configuration.token_name]
    end
  end
end
