module Oceanarium
  class Size
    attr_accessor :id, :name

    def initialize(option, api_key, client_id)
      if api_key.nil? || client_id.nil?
        raise 'No API key/client ID!'
      else
        if option.is_a?(Hash)
          @object = option
        end
        if @object.nil?
          self.id = nil
        else
          self.id = @object['id']
          self.name = @object['name']
        end
      end
    end

    # Core API

    def self.all
      # Returns all avaliable sizess in Array
      @request = Oceanarium::Request.new
      @get = @request.get('/sizes/')
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['sizes']
      end
    end
  end
end
