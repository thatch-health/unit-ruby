module Unit
  module Types
    class Array
      attr_reader :items

      def initialize(items)
        @items = items || []
      end

      def self.cast(val)
        return val if val.is_a? self

        new(val)
      end

      def as_json_api
        items.map do |item|
          item.respond_to?(:as_json_api) ? item.as_json_api : item
        end
      end
    end
  end
end
