module Oceanarium
  class Event
    attr_accessor :id, :action_status, :droplet_id, :event_type_id, :percentage

    def initialize(option, api_key, client_id)
      if api_key.nil? || client_id.nil?
        raise 'No API key/client ID!'
      else
        if option.is_a?(Hash)
          @object = option
        else
          @object = Oceanarium::Event.find(option)
        end
        if @object.nil?
          self.id = nil
        else
          self.id = @object['id']
          self.action_status = @object['action_status']
          self.droplet_id = @object['droplet_id']
          self.event_type_id = @object['event_type_id']
          self.percentage = @object['percentage']
        end
      end
    end

    # Core API

    def self.find(id)
      @request = Oceanarium::Request.new
      @get = @request.get("/events/#{id}/")
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['event']
      end
    end
  end
end