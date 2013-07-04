require 'open-uri'

module Oceanarium
  class SSHKey

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
