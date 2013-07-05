require "httparty"

require "oceanarium/version"
require "oceanarium/config"
require "oceanarium/request"
require "oceanarium/resources"

module Oceanarium
  # User API roots:
  # /droplets/

  def self.droplet(id = nil)
    Oceanarium::Droplet.new(id, Oceanarium::Config.api_key, Oceanarium::Config.client_id)
  end

  def self.droplets
    unless Oceanarium::Config.api_key.nil? || Oceanarium::Config.client_id.nil?
      @droplets = Array.new()
      Oceanarium::Droplet.all.each do |droplet|
        @object = Oceanarium::Droplet.new(droplet, Oceanarium::Config.api_key, Oceanarium::Config.client_id)
        @droplets << @object
      end
      @droplets
    end
  end

  # /images/

  def self.image(id = nil)
    Oceanarium::Image.new(id, Oceanarium::Config.api_key, Oceanarium::Config.client_id)
  end

  def self.images(scope = nil)
    unless Oceanarium::Config.api_key.nil? || Oceanarium::Config.client_id.nil?
      @images = Array.new()
      if scope.nil?
        Oceanarium::Image.all.each do |image|
          @object = Oceanarium::Image.new(image, Oceanarium::Config.api_key, Oceanarium::Config.client_id)
          @images << @object
        end
      elsif scope == 'global'
        Oceanarium::Image.global.each do |image|
          @object = Oceanarium::Image.new(image, Oceanarium::Config.api_key, Oceanarium::Config.client_id)
          @images << @object
        end
      elsif scope == 'my_images'
        Oceanarium::Image.local.each do |image|
          @object = Oceanarium::Image.new(image, Oceanarium::Config.api_key, Oceanarium::Config.client_id)
          @images << @object
        end
      end
    end
    @images
  end

  # /ssh_keys/

  def self.ssh_key(id = nil)
    Oceanarium::SSHKey.new(id, Oceanarium::Config.api_key, Oceanarium::Config.client_id)
  end

  def self.ssh_keys
    unless Oceanarium::Config.api_key.nil? || Oceanarium::Config.client_id.nil?
      @keys = Array.new()
      Oceanarium::SSHKey.all.each do |key|
        @object = Oceanarium::SSHKey.new(key, Oceanarium::Config.api_key, Oceanarium::Config.client_id)
        @keys << @object
      end
      @keys
    end
  end
end
