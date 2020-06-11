# frozen_string_literal: true

module MoyskladIntegration
  class Connector
    API_URL_LOGIN = 'https://online.moysklad.ru/api/remap/1.1'

    attr_reader :connection

    def initialize
      @connection = Faraday.new(url: API_URL_LOGIN, headers: { 'Content-Type': 'application/json' })
      @connection.basic_auth(ENV['MOYSKLAD_USERNAME'], ENV['MOYSKLAD_PASSWORD'])
    end
  end
end
