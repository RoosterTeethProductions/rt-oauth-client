module Rt
  module Oauth
    module Client
      class Engine < ::Rails::Engine
        isolate_namespace Rt::Oauth::Client
        config.rt_oauth_client = Client
      end
    end
  end
end
