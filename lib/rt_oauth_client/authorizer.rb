require 'oauth2'
module RtOauthClient
  module Authorizer
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

    def me
      @me ||= JSON.parse(user_token.get('/api/v1/me').body) rescue nil
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
