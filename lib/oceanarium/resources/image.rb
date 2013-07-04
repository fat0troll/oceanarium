module Oceanarium
  class Image

    def self.all
      # Returns all avaliable images in Array
      @request = Oceanarium::Request.new
      @get = @request.get('/images/')
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['images']
      end
    end

    def self.global
      # Returns all global images in Array
      @request = Oceanarium::Request.new
      @get = @request.get('/images/?filter=global')
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['images']
      end
    end

    def self.local
      # Returns all user's images in Array
      @request = Oceanarium::Request.new
      @get = @request.get('/images/?filter=my_images')
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['images']
      end
    end

    def self.find(id)
      @request = Oceanarium::Request.new
      @get = @request.get("/images/#{id}/")
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['image']
      end
    end

    def self.find_by_name(string)
      # Returns Array of images which name matching string.
      self.all.select { |i| i['name'].include? string }
    end

    def self.destroy(id)
      @request = Oceanarium::Request.new
      @get = @request.get("/images/#{id}/destroy/")
      @get.parsed_response['status']
    end

    def self.transfer(id, region_id)
      @request = Oceanarium::Request.new
      @get = @request.get("/images/#{id}/transfer/?region_id=#{region_id}")
      @get.parsed_response['status']
    end
  end
end
