require 'open-uri'

module Oceanarium
  class SSHKey
    attr_accessor :id, :name, :ssh_pub_key

    def initialize(option, api_key, client_id)
      if api_key.nil? || client_id.nil?
        raise 'No API key/client ID!'
      else
        if option.is_a?(Hash)
          @object = option
        else
          @object = Oceanarium::SSHKey.find(option)
        end
        if @object.nil?
          self.id = nil
        else
          self.id = @object['id']
          self.name = @object['name']
          self.ssh_pub_key = @object['ssh_pub_key']
        end
      end
    end

    # User API

    def edit(key)
      Oceanarium::SSHKey.update(self.id, key)
    end

    def destroy
      Oceanarium::SSHKey.destroy(self.id)
    end

    # Core API

    def self.all
      # Returns all ssh keys in Array
      @request = Oceanarium::Request.new
      @get = @request.get('/ssh_keys/')
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['ssh_keys']
      end
    end

    def self.create(name, key)
      # Creates ssh_key
      @request = Oceanarium::Request.new
      @get = @request.get(URI::encode("/ssh_keys/new?name=#{name}&ssh_pub_key=#{key}"))
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['ssh_key']['id']
      else
        @get.parsed_response['status']
      end
    end

    def self.find(id)
      # Returns ssh key
      @request = Oceanarium::Request.new
      @get = @request.get("/ssh_keys/#{id}/")
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['ssh_key']
      end
    end

    def self.update(id, key)
      # Updates ssh key
      @request = Oceanarium::Request.new
      @get = @request.get(URI::encode("/ssh_keys/#{id}/edit?ssh_key_pub=#{key}"))
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['ssh_key']
      end
    end

    def self.destroy(id)
      # Destroys ssh key
      @request = Oceanarium::Request.new
      @get = @request.get("/ssh_keys/#{id}/destroy")
      @get.parsed_response['status']
    end
  end
end
