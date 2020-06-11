# frozen_string_literal: true

module MoyskladIntegration
  class Entity
    def initialize(params)
      params.each do |key, val|
        next if val.blank?

        self.class.__send__(:define_method, key, -> { instance_variable_get("@#{key}") })
        self.class.__send__(:define_method, "#{key}=", ->(val) { instance_variable_set("@#{key}", val) })
        __send__("#{key}=", val)
      end
    end

    def update(params)
      service.update(self, params)
    end

    def meta_link
      { meta: meta }
    end

    def add_positions(positions_params)
      service.create_positions(self, positions_params)
    end

    def update_positions(positions_params)
      current_positions = service.get_positions(self)
      current_positions.map! do |current_position|
        current_position.instance_variables.each_with_object({}) do |var, hash|
          key = var.to_s.delete('@').to_sym
          keys_to_compare = positions_params.select { |position| position.dig(:assortment, 'meta', 'uuidHref') == current_position.instance_variable_get(:@assortment).dig('meta', 'uuidHref') }.first&.keys

          next if keys_to_compare.present? && !keys_to_compare&.include?(key)

          hash[key] = current_position.instance_variable_get(var)
        end
      end

      new_positions = (positions_params - current_positions)
      removed_positions = (current_positions - positions_params)
      service.create_positions(self, new_positions) if new_positions.present?
      service.delete_positions(self, removed_positions) if removed_positions.present?
    end

    private

    def service
      Service.new
    end
  end
end
