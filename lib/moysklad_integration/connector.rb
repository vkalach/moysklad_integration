require 'faraday'

module MoyskladIntegration
  class Connector
    API_URL_LOGIN = 'https://online.moysklad.ru/api/remap/1.1'

    attr_reader :connection

    def initialize
      @connection = Faraday.new(API_URL_LOGIN)
      @connection.basic_auth(ENV['USERNAME'], ENV['PASSWORD'])
    end
  end
end