module Oceanarium
  class Region
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

    def self.all
      # Returns all avaliable regions in Array
      @request = Oceanarium::Request.new
      @get = @request.get('/regions/')
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['regions']
      end
    end
  end
end
