module Oceanarium
  class Record

    def all(domain_id)
      @request = Oceanarium::Request.new
      @get = @request.get("/domains/#{domain_id}/records")
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['records']
      end
    end

    def find(domain_id, id)
      @request = Oceanarium::Request.new
      @get = @request.get("/domains/#{domain_id}/records/#{id}/")
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['record']
      end
    end

    def create(domain_id, options={})
      # There is a gotcha: too many params, so we need to pass an Hash with all params.
      # For example:
      #
      #       Oceanarium::Record.create(100500, {:record_type => 'A', :data => 'www.example.com', :name => 'example', :priority => 1, :port => 8342, :weight => 1 })
      #
      # Looks a lot overbloated? Yes, I know it :(
      @request = Oceanarium::Request.new
      @get = @request.get("/domains/#{domain_id}/records/new", options)
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['domain_record']['id']
      else
        @get.parsed_response['status']
      end
    end

    def update(domain_id, options={})
      # Same shit there
      @request = Oceanarium::Request.new
      @get = @request.get("/domains/#{domain_id}/records/new", options)
      if @get.parsed_response['status'] == 'OK'
        @get.parsed_response['record']
      else
        @get.parsed_response['status']
      end
    end

    def destroy(domain_id, id)
      @request = Oceanarium::Request.new
      @get = @request.get("/domains/#{domain_id}/records/#{id}/destroy")
      @get.parsed_response['status']
    end
  end
end
