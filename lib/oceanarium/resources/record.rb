module Oceanarium
  class Record
    attr_accessor :id, :domain_id, :record_type, :name, :data, :priority, :port, :weight

    def initialize(option, api_key, config_id, domain_id = nil)
      if api_key.nil? || config_id.nil?
        raise 'No API key/client ID!'
      else
        if option.is_a?(Hash)
          @object = option
        else
          @object = Oceanarium::Record.find(option, domain_id)
        end
        if @object.nil?
          self.id = nil
        else
          self.id = @object['id']
          self.domain_id = @object['domain_id']
          self.record_type = @object['record_type']
          self.name = @object['name']
          self.data = @object['data']
          self.priority = @object['priority']
          self.port = @object['port']
          self.weight = @object['weight']
        end
      end
    end

    # User API

    def new(options={})
      Oceanarium::Record.create(self.domain_id, options)
    end

    def edit(options={})
      Oceanarium::Record.update(self.id, self.domain_id, options)
    end

    def destroy
      Oceanarium::Record.destroy(self.domain_id, self.id)
    end

    # Core API

    def self.all(domain_id)
      @request = Oceanarium::Request.new
      @get = @request.get("/domains/#{domain_id}/records")
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['records']
      end
    end

    def self.find(domain_id, id)
      @request = Oceanarium::Request.new
      @get = @request.get("/domains/#{domain_id}/records/#{id}/")
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['record']
      end
    end

    def self.create(domain_id, options={})
      # There is a gotcha: too many params, so we need to pass an Hash with all params.
      # For example:
      #
      #       Oceanarium::Record.create(100500, {:record_type => 'A', :data => 'www.example.com', :name => 'example', :priority => 1, :port => 8342, :weight => 1 })
      #
      # Looks a lot overbloated? Yes, I know it :(
      @request = Oceanarium::Request.new
      @get = @request.get("/domains/#{domain_id}/records/new", options)
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['domain_record']['id']
      else
        @get.parsed_response['status']
      end
    end

    def self.update(id, domain_id, options={})
      # Same shit there
      @request = Oceanarium::Request.new
      @get = @request.get("/domains/#{domain_id}/records/#{id}/edit/", options)
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['record']
      else
        @get.parsed_response['status']
      end
    end

    def self.destroy(domain_id, id)
      @request = Oceanarium::Request.new
      @get = @request.get("/domains/#{domain_id}/records/#{id}/destroy")
      @get.parsed_response['status']
    end
  end
end
