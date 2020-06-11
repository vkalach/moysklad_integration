# frozen_string_literal: true

require 'log4r'
require 'faraday'
require 'json'
require 'active_support'
require 'addressable/uri'
require 'moysklad_integration/version'
require 'moysklad_integration/connector'
require 'moysklad_integration/service'
require 'moysklad_integration/entity'

module MoyskladIntegration
  class Error < StandardError; end
  Faraday::Utils.default_uri_parser = ->(uri) { Addressable::URI.parse(uri) }

  def self.logger
    @log = Log4r::Logger.new(name)
    @log.outputters << Log4r::StdoutOutputter.new('log_stdout')
    @log.level = Log4r::INFO
    @log
  end
end
