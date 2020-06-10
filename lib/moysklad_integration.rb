require "moysklad_integration/connector"
require "moysklad_integration/version"
require "moysklad_integration/service"

Dir["./lib/moysklad_integration/entities/*.rb"].each { |file| require file }

module MoyskladIntegration
  class Error < StandardError; end
  # Your code goes here...
end
