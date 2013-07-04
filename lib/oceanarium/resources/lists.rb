module Oceanarium
  class Lists

    def self.regions
      # Returns all avaliable regions in Array
      @request = Oceanarium::Request.new
      @get = @request.get('/regions/')
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['regions']
      end
    end

    def self.sizes
      # Returns all avaliable sizess in Array
      @request = Oceanarium::Request.new
      @get = @request.get('/sizes/')
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['sizes']
      end
    end
  end
end
