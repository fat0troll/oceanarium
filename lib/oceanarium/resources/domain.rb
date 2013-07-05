require 'oceanarium/config'
require 'oceanarium/resources/record'

module Oceanarium
  class Domain
    attr_accessor :id, :name, :ttl, :live_zone_file

    def initialize(option, api_key, config_id)
      if api_key.nil? || config_id.nil?
        raise 'No API key/client ID!'
      else
        if option.is_a?(Hash)
          @object = option
        else
          @object = Oceanarium::Domain.find(option)
        end
        if @object.nil?
          self.id = nil
        else
          self.id = @object['id']
          self.name = @object['name']
          self.ttl = @object['ttl']
          self.live_zone_file = @object['live_zone_file']
        end
      end
    end

    def self.record(id = nil)
      Oceanarium::Record.new(id, Oceanarium::Config.api_key, Oceanarium::Config.client_id, self.id)
    end

    def self.records
      unless Oceanarium::Config.api_key.nil? || Oceanarium::Config.client_id.nil?
        @records = Array.new()
        Oceanarium::Record.all(self.id).each do |record|
          @object = Oceanarium::Record.new(record, Oceanarium::Config.api_key, Oceanarium::Config.client_id)
          @records << @object
        end
        @records
      end
    end

    # User API

    def new(name, ip_addr)
      @new_id = Oceanarium::Domain.create(name, ip_addr)
      unless @new_id == 'ERROR'
        Oceanarium::domain(@new_id)
      end
    end

    def destroy
      Oceanarium::Domain.destroy(self.id)
    end

    # Core API

    def self.all
      @request = Oceanarium::Request.new
      @get = @request.get('/domains/')
      @get.parsed_response['domains']
    end

    def self.find(id)
      @request = Oceanarium::Request.new
      @get = @request.get("/domains/#{id}")
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['domain']
      else
        @get.parsed_response['status']
      end
    end

    def self.search_by_name(string)
      # Returns Array of domains which name matching string.
      self.all.select { |i| i['name'].include? string }
    end

    def self.find_by_name(string)
      # Returns domain which name equals string.
      self.all.select { |i| i['name'] == string }
    end

    def self.create(name, ip_addr)
      @request = Oceanarium::Request.new
      @get = @request.get("/domains/new?name=#{name}&ip_address=#{ip_addr}")
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['domain']['id']
      else
        @get.parsed_response['status']
      end
    end

    def self.destroy(id)
      @request = Oceanarium::Request.new
      @get = @request.get("/domains/#{id}/destroy/")
      @get.parsed_response['status']
    end
  end
end
