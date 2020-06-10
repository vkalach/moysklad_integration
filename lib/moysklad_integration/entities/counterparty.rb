module MoyskladIntegration
  module Entities
    class Counterparty < MoyskladIntegration::Entities::Base
      attr_accessor :email, :name, :phone

      def initialize(**args)
        binding.pry
      end
    end
  end
end