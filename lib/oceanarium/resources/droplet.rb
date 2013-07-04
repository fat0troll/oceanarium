module Oceanarium
  class Droplet

    def self.all
      # Returns all Droplets in Array. Each Droplet is a Hash
      @request = Oceanarium::Request.new
      @get = @request.get('/droplets/')
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['droplets']
      end
    end

    def self.find(id)
      # Returns single Droplet Hash. Returns nil if error
      @request = Oceanarium::Request.new
      @get = @request.get("/droplets/#{id}")
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['droplet']
      end
    end

    def self.create(name, size_id, image_id, region_id, ssh_key_ids=nil)
      @request = Oceanarium::Request.new
      if ssh_key_ids.nil?
        @get = @request.get("/droplets/new?name=#{name}&size_id=#{size_id}&image_id=#{image_id}&region_id=#{region_id}")
      else
        @get = @request.get("/droplets/new?name=#{name}&size_id=#{size_id}&image_id=#{image_id}&region_id=#{region_id}&ssh_key_ids=#{ssh_key_ids}")
      end
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['droplet']['id']
      else
        @get.parsed_response['status']
      end
    end

    def self.action(id, action)
      # Performs single action to a Droplet. Returns status OK or Error
      @approved_actions = ['reboot', 'power_cycle', 'shutdown', 'power_off', 'power_on', 'password_reset', 'enable_backups', 'disable_backups', 'destroy']
      if @approved_actions.include? action
        @request = Oceanarium::Request.new
        @get = @request.get("/droplets/#{id}/#{action}")
        @get.parsed_response['status']
      else
        'ERROR'
      end
    end

    def self.resize(id, size_id)
      # Resizes Droplet. Returns OK or Error
      @request = Oceanarium::Request.new
      @sizes_request_get = @request.get("/sizes/")
      @sizes = @sizes_request_get.parsed_response['sizes']
      if @sizes.select { |s| s['id'] == size_id }.empty?
        'Error'
      else
        @get = @request.get("/droplets/#{id}/resize?size_id=#{size_id}")
        @get.parsed_response['status']
      end
    end

    def self.rename(id, name)
      # Renames Droplet. Name must be FQDN. Returns OK or Error
      @request = Oceanarium::Request.new
      @get = @request.get("/droplets/#{id}/rename/?name=#{name}")
      @get.parsed_response['status']
    end

    def self.snapshot(id, name)
      # Makes snapshot of Droplet. Returns OK or Error
      @request = Oceanarium::Request.new
      @get = @request.get("/droplets/#{id}/snapshot?name=#{name}")
      @get.parsed_response['status']
    end

    def self.restore(id, image_id)
      # Restores snapshot of Droplet. Returns OK or Error
      @request = Oceanarium::Request.new
      @get = @request.get("/droplets/#{id}/restore/?image_id=#{image_id}")
      @get.parsed_response['status']
    end

    def self.rebuild(id, image_id)
      # Rebuild OS image on Droplet. Returns OK or Error
      @request = Oceanarium::Request.new
      @get = @request.get("/droplets/#{id}/rebuild/?image_id=#{image_id}")
      @get.parsed_response['status']
    end

    def self.destroy(id)
      # Destroys Droplet
      @request = Oceanarium::Request.new
      @get = @request.get("/droplets/#{id}/destroy/")
      @get.parsed_response['status']
    end
  end
end
