module Oceanarium
  class Domain

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
