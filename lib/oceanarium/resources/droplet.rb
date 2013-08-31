require 'open-uri'

module Oceanarium
  class Droplet
    attr_accessor :id, :name, :image_id, :size_id, :region_id, :backups_active, :ip_address, :locked, :status, :created_at

    def initialize(option, api_key, config_id)
      if api_key.nil? || config_id.nil?
        raise 'No API key/client ID!'
      else
        if option.is_a?(Hash)
          @object = option
        else
          @object = Oceanarium::Droplet.find(option)
        end
        if @object.nil?
          self.id = nil
        else
          self.id = @object['id']
          self.name = @object['name']
          self.image_id = @object['image_id']
          self.size_id = @object['size_id']
          self.region_id = @object['region_id']
          self.backups_active = @object['backups_active']
          self.ip_address = @object['ip_address']
          self.locked = @object['locked']
          self.status = @object['status']
          self.created_at = @object['created_at']
        end
      end
    end

    # User API

    def new(name, size_id, image_id, region_id, ssh_key_ids=nil)
      @new_id = Oceanarium::Droplet.create(name, size_id, image_id, region_id, ssh_key_ids=nil)
      unless @new_id['status'] == 'ERROR'
        [Oceanarium::droplet(@new_id['droplet']['id']), @new_id['droplet']['event_id']]
      end
    end

    def reboot
      Oceanarium::Droplet::action(self.id, 'reboot')
    end

    def power_cycle
      Oceanarium::Droplet::action(self.id, 'power_cycle')
    end

    def shutdown
      Oceanarium::Droplet::action(self.id, 'shutdown')
    end

    def power_off
      Oceanarium::Droplet::action(self.id, 'power_off')
    end

    def power_on
      Oceanarium::Droplet::action(self.id, 'power_on')
    end

    def password_reset
      Oceanarium::Droplet::action(self.id, 'password_reset')
    end

    def resize(size_id)
      Oceanarium::Droplet.resize(self.id, size_id)
    end

    def snapshot(name)
      Oceanarium::Droplet.snapshot(self.id, name)
    end

    def restore(image_id)
      Oceanarium::Droplet.restore(self.id, image_id)
    end

    def rebuild(image_id)
      Oceanarium::Droplet.rebuild(self.id, image_id)
    end

    def enable_backups
      Oceanarium::Droplet::action(self.id, 'enable_backups')
    end

    def disable_backups
      Oceanarium::Droplet::action(self.id, 'disable_backups')
    end

    def rename(new_name)
      Oceanarium::Droplet.rename(self.id, new_name)
    end

    def destroy
      Oceanarium::Droplet::action(self.id, 'destroy')
    end

    # Core API

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
        @get = @request.get(URI::encode("/droplets/new?name=#{name}&size_id=#{size_id}&image_id=#{image_id}&region_id=#{region_id}"))
      else
        @get = @request.get(URI::encode("/droplets/new?name=#{name}&size_id=#{size_id}&image_id=#{image_id}&region_id=#{region_id}&ssh_key_ids=#{ssh_key_ids}"))
      end
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response
      else
        @get.parsed_response
      end
    end

    def self.action(id, action)
      # Performs single action to a Droplet. Returns status OK or Error
      @approved_actions = ['reboot', 'power_cycle', 'shutdown', 'power_off', 'power_on', 'password_reset', 'enable_backups', 'disable_backups', 'destroy']
      if @approved_actions.include? action
        @request = Oceanarium::Request.new
        @get = @request.get("/droplets/#{id}/#{action}")
        return [@get.parsed_response['status'], @get.parsed_response['event_id']]
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
        [@get.parsed_response['status'], @get.parsed_response['event_id']]
      end
    end

    def self.rename(id, name)
      # Renames Droplet. Name must be FQDN. Returns OK or Error
      @request = Oceanarium::Request.new
      @get = @request.get("/droplets/#{id}/rename/?name=#{name}")
      [@get.parsed_response['status'], @get.parsed_response['event_id']]
    end

    def self.snapshot(id, name)
      # Makes snapshot of Droplet. Returns OK or Error
      @request = Oceanarium::Request.new
      @get = @request.get("/droplets/#{id}/snapshot?name=#{name}")
      [@get.parsed_response['status'], @get.parsed_response['event_id']]
    end

    def self.restore(id, image_id)
      # Restores snapshot of Droplet. Returns OK or Error
      @request = Oceanarium::Request.new
      @get = @request.get("/droplets/#{id}/restore/?image_id=#{image_id}")
      [@get.parsed_response['status'], @get.parsed_response['event_id']]
    end

    def self.rebuild(id, image_id)
      # Rebuild OS image on Droplet. Returns OK or Error
      @request = Oceanarium::Request.new
      @get = @request.get("/droplets/#{id}/rebuild/?image_id=#{image_id}")
      [@get.parsed_response['status'], @get.parsed_response['event_id']]
    end

    def self.destroy(id)
      # Destroys Droplet
      @request = Oceanarium::Request.new
      @get = @request.get("/droplets/#{id}/destroy/")
      [@get.parsed_response['status'], @get.parsed_response['event_id']]
    end
  end
end
