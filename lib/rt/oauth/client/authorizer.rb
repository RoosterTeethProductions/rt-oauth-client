require "rt/oauth/client/authorizer"

module Rt::Oauth::Client
  module Authorizer
    extend ActiveSupport::Concern
    included do
    end

    def authorize!(token)
      @authorization = begin
        _response = HTTParty.get(
          Rt::Oauth::Client.configuration.oauth_url,
          query:   {Rt::Oauth::Client.configuration.token_name => token},
          headers: {
            'X-Client-Id'     => Rt::Oauth::Client.configuration.client_id,
            'X-Client-Secret' => Rt::Oauth::Client.configuration.client_secret,
            'Accept'          => 'application/json',
            'Content-Type'    => 'application/json'
          }
        )
          # client = Rack::OAuth2::Client.new(
          #   :identifier => self.class.client_id,
          #   :secret => self.class.client_secret,
          #   # :redirect_uri => self.class.redirect_uri, # only required for grant_type = :code
          #   :host => 'http://localhost:4200'
          # )
          # client.authorization_uri(:response_type => :token, :scope => :user_about_me)
      end
    end

  end
end
