require 'oauth2'
module RtOauthClient
  module Authorizer
    class ResponseError < StandardError

    end

    extend ActiveSupport::Concern
    included do
      attr_accessor :user_token, :app_token
    end

    def authorize_app!(scope = 'public')
      @app_token ||= begin
        client.client_credentials.get_token(scope: scope)
      end
    end

    def authorize_user!(username, password, scope = 'user')
      @user_token ||= client.password.get_token(username, password, scope: scope)
    end

    def client
      @client ||= OAuth2::Client.new(
        RtOauthClient.configuration.client_id,
        RtOauthClient.configuration.client_secret,
        site: token_uri
      )
    end

    # Here we overwrite #user_token to get the same functionality when a token is passed in
    def set_bearer_token(token)
      @user_token ||= begin
        _client                    = client.dup
        _client.connection.headers = client.connection.headers.merge({'Authorization' => "Bearer #{token}"})
        _client.connection
      end
    end

    def token_info
      if @token_info
        return @token_info
      end
      response_body = user_token.get("/oauth/token/info").body
      response_json = JSON.parse(response_body)
      if response_json["error"]
        raise ResponseError, response_body
      else
        @token_info = response_json
      end
    end

    def me
      @me ||= begin
        my_json = JSON.parse(user_token.get('/api/v1/me').body) # my_json could be {"error": "Unauthorized", "message": "The access token is invalid"}
        if my_json["id"].blank?
          nil
        else
          my_json
        end
      rescue
        nil
      end
    end

    def app_token
      @app_token ||= raise "Must call #authorize_app! first"
    end

    def user_token
      @user_token ||= raise "Must call #authorize_user! first"
    end

    def token_uri
      File.join(RtOauthClient.configuration.oauth_uri, RtOauthClient.configuration.token_path).to_s
    end

    def authorize_uri
      File.join(RtOauthClient.configuration.oauth_uri, RtOauthClient.configuration.authorize_path).to_s
    end

  end
end
