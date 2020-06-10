module MoyskladIntegration
  class Service
    attr_accessor :connection

    def initialize
      @connection = MoyskladIntegration::Connector.new.connection
    end

    def create(object)

    end
  end
end