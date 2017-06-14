module RtOauthClient
  class ApplicationController < ActionController::Base
    include RtOauthClient::Protector
  end
end
