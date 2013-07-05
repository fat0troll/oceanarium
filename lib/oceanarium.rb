require "httparty"

require "oceanarium/version"
require "oceanarium/config"
require "oceanarium/request"
require "oceanarium/resources"

module Oceanarium
  # Human API roots
  # /droplets/
  def self.droplet(id = nil)
    Oceanarium::Droplet.new(id, Oceanarium::Config.api_key, Oceanarium::Config.client_id)
  end

  def self.droplets
    unless Oceanarium::Config.api_key.nil? || Oceanarium::Config.client_id.nil?
      @droplets = Array.new()
      Oceanarium::Droplet.all.each do |droplet|
        @object = Oceanarium::droplet(droplet['id'])
        @droplets << @object
      end
      @droplets
    end
  end
  # /images/
  def self.image(id = nil)
    Oceanarium::Image.new(id, Oceanarium::Config.api_key, Oceanarium::Config.client_id)
  end

  # TODO: optimize
  def self.images
    unless Oceanarium::Config.api_key.nil? || Oceanarium::Config.client_id.nil?
      @images = Array.new()
      Oceanarium::Image.all.each do |image|
        @object = Oceanarium::image(image['id'])
        @images << @object
      end
    end
    @images
  end
end
