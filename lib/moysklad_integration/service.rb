# frozen_string_literal: false

module MoyskladIntegration
  class Service
    attr_accessor :connection

    def initialize
      @connection = MoyskladIntegration::Connector.new.connection
    end

    def create(object_name, params)
      initialize_entity(object_name, params)
      response = connection.post(entity_path, entity_instance.to_json)
      if response.status == 200
        Entity.new(JSON.parse(response.body))
      else
        JSON.parse(response.body)['errors'].each do |error|
          MoyskladIntegration.logger.warn(error['error'])
        end
      end
    end

    def filter(object_name, params)
      initialize_entity(object_name, params)
      params_for_filter = params.each_with_object('') { |(k, v), str| str << "#{k}=#{v};" }
      response = connection.get("#{entity_path}?filter=#{params_for_filter}")
      if response.status == 200
        JSON.parse(response.body)['rows'].each_with_object([]) do |entity_params, arr|
          arr << Entity.new(entity_params)
        end
      end
    end

    def get(object_name, id = nil)
      @entity_path = id ? "entity/#{object_name.downcase}/#{id}" : "entity/#{object_name.downcase}"
      response = connection.get(entity_path)
      if response.status == 200
        if id
          Entity.new(JSON.parse(response.body))
        else
          JSON.parse(response.body)['rows'].each_with_object([]) do |entity_params, arr|
            arr << Entity.new(entity_params)
          end
        end
      end
    end

    def update(object, params)
      params.delete_if do |k, v|
        object.__send__(k) == (v.is_a?(String) ? v : v.collect { |key, val| [key.to_s, val] }.to_h)
      end
      @entity_path = "entity/#{object.meta['type']}/#{object.id}"
      response = connection.put(entity_path.to_s, params.to_json)
    end

    def create_positions(object, positions_params)
      @entity_path = "entity/#{object.meta['type']}/#{object.id}/positions"
      response = connection.post(entity_path, positions_params.to_json)
    end

    def get_positions(object)
      @entity_path = "entity/#{object.meta['type']}/#{object.id}/positions"
      response = connection.get(entity_path)
      if response.status == 200
        JSON.parse(response.body)['rows'].each_with_object([]) do |entity_params, arr|
          arr << Entity.new(entity_params)
        end
      end
    end

    def delete_positions(object, positions)
      positions.each do |position|
        @entity_path = "entity/#{object.meta['type']}/#{object.id}/positions/#{position[:id]}"
        response = connection.delete(entity_path)
      end
    end

    private

    attr_reader :entity_instance, :entity_path

    def initialize_entity(object_name, params)
      @entity_instance = Entity.new(params)
      @entity_path = "entity/#{object_name.downcase}"
    end
  end
end
