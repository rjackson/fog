module Fog
  module Compute
    class RackspaceV2
      class Real
        
        # Retrieves list of servers
        # @return [Excon::Response] response:
        #   * body [Hash]:
        #     * server [Hash]:
        #       * OS-DCF:diskConfig [String] - The disk configuration value.
        #       * OS-EXT-STS:power_state [Fixnum] - The power state.
        #       * OS-EXT-STS:task_state [String] - The task state.        
        #       * OS-EXT-STS:vm_state [String] - The VM state.
        #       * accessIPv4 [String] - The public IP version 4 access address.
        #       * accessIPv6 [String] - The public IP version 6 access address.
        #       * addresses [Hash] - Public and private IP addresses, The version field indicates whether the IP address is version 4 or 6.        
        #       * created [String] - created timestamp
        #       * hostId [String] - The host id. 
        #       * id [String] - id of image
        #       * image [Hash]:
        #         * id [String] - id of the image
        #         * links [Hash] - links to image
        #       * flavor [Hash]:
        #         * id [String] - id of the flavor
        #         * links [Hash] - links to flavor
        #       * links [Hash] - links to server
        #       * metadata [Hash] - server metadata
        #       * name [String] - name of server
        #       * progress [Fixnum] - progress complete. Value is from 0 to 100.
        #       * rax-bandwidth:bandwidth [Array] - The amount of bandwidth used for the specified audit period.
        #       * status [String] - The server status.
        #       * tenant_id [String] - The tenant ID.
        #       * updated [String] - updated timestamp
        #       * user_id [Array] - The user ID.
        # @raise [Fog::Compute::RackspaceV2::NotFound] - HTTP 404
        # @raise [Fog::Compute::RackspaceV2::BadRequest] - HTTP 400
        # @raise [Fog::Compute::RackspaceV2::InternalServerError] - HTTP 500
        # @raise [Fog::Compute::RackspaceV2::ServiceError]
        # @see http://docs.rackspace.com/servers/api/v2/cs-devguide/content/List_Servers-d1e2078.html       
        def list_servers
          request(
            :expects => [200, 203, 300],
            :method => 'GET',
            :path => 'servers/detail'
          )
        end
      end

      class Mock
        def list_servers
          servers = self.data[:servers].values.map { |s| Fog::Rackspace::MockData.keep(s, 'id', 'name', 'hostId', 'created', 'updated', 'status', 'progress', 'user_id', 'tenant_id', 'links', 'metadata') }
          response(:body => {"servers" => servers})
        end
      end
    end
  end
end
