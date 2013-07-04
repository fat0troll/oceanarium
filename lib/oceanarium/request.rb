require 'pry-remote'

module Oceanarium
  class Request
    include HTTParty

    base_uri Oceanarium::Config.api_url

    def get(path, options={})
      options.merge!({:client_id => Oceanarium::Config.client_id.to_s, :api_key => Oceanarium::Config.api_key.to_s})
      self.class.get(path, :query => options)
    end
  end
end
