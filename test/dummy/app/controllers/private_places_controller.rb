require 'rt/oauth/client'
require 'rt/oauth/client/protector'
class PrivatePlacesController < ApplicationController
  include Rt::Oauth::Client::Protector

  # GET /private_places
  def index
    head :ok
  end

end
