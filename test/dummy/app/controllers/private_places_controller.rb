class PrivatePlacesController < ApplicationController
  include RtOauthClient::Protector

  # GET /private_places
  def index
    head :ok
  end

end
