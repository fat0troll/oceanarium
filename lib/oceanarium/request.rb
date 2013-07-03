require 'pry-remote'

module Oceanarium
  class Request
    include HTTParty

    base_uri Oceanarium::Config.api_url

    def get(path)
      self.class.get(path, :query => {:client_id => Oceanarium::Config.client_id.to_s, :api_key => Oceanarium::Config.api_key.to_s})
    end
  end
end
