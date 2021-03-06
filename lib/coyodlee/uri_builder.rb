module Coyodlee
  class UriBuilder
    attr_reader :host

    def initialize(host:, cobrand_name: 'restserver', version: 'v1')
      @cobrand_name = cobrand_name
      @version = version
      @host = host
      @path_prefix = 'ysl'
    end

    def build(resource_path, query: nil, use_ssl: true)
      uri_builder = use_ssl ? URI::HTTPS : URI::HTTP
      revised_resource_path = if resource_path.start_with?('/')
                                resource_path.slice(1..-1)
                              else
                                resource_path
                              end
      path = [@path_prefix, @cobrand_name, @version, revised_resource_path]
               .compact
               .join('/')
               .prepend('/')
      uri_builder.build(host: @host, path: path, query: query)
    end
  end
end
