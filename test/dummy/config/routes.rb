Rails.application.routes.draw do
  resources :private_places
  mount RtOauthClient::Engine => "/rt-oauth-client"
end
