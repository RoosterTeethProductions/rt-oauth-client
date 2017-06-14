Rails.application.routes.draw do
  resources :private_places
  mount Rt::Oauth::Client::Engine => "/rt-oauth-client"
end
