require 'oauth2'
module RtOauthClient
  module RequestHelper
    extend ActiveSupport::Concern
    include RtOauthClient::BearerToken

    included do
      def get(url)
        HTTParty.get(url, headers)
      end

      def put(url, params)
        HTTParty.put(url, body: params)
      end

      def post(url, params)
        HTTParty.post(url, body: params)
      end

      def delete(url, params)
        HTTParty.post(url, body: params)
      end

      private
      def headers
        {"Authorization" => "Bearer " + find_bearer_token}
      end
    end
  end
end
