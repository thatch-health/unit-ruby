module Unit
  module Types
    class UsNexus
      # Nature of the business's ties to the U.S.
      # Either NotAvailable or one or more of the other values.
      NOT_AVAILABLE = 'NotAvailable'
      EMPLOYEES = 'Employees'
      CUSTOMERS = 'Customers'
      PHYSICAL_OFFICE_OR_FACILITY = 'PhysicalOfficeOrFacility'
      BANKING_RELATIONSHIPS = 'BankingRelationships'

      ALLOWED_VALUES = constants(false).map { |c| const_get(c) }.freeze

      def self.cast(value)
        return nil if value.nil?

        string_value = value.to_s

        unless ALLOWED_VALUES.include?(string_value)
          raise ArgumentError, "Invalid US nexus: #{value.inspect}. Allowed values: #{ALLOWED_VALUES.join(', ')}"
        end

        string_value
      end

      def self.values
        ALLOWED_VALUES
      end
    end
  end
end
