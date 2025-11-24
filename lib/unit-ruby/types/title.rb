module Unit
    module Types
      class Title
        # Enum values as constants
        CEO = 'CEO'
        COO = 'COO'
        CFO = 'CFO'
        PRESIDENT = 'President'
        BENEFITS_ADMINISTRATION_OFFICER = 'BenefitsAdministrationOfficer'
        CIO = 'CIO'
        VP = 'VP'
        AVP = 'AVP'
        TREASURER = 'Treasurer'
        SECRETARY = 'Secretary'
        CONTROLLER = 'Controller'
        MANAGER = 'Manager'
        PARTNER = 'Partner'
        MEMBER = 'Member'
  
        ALLOWED_VALUES = constants(false).map { |c| const_get(c) }.freeze
  
        def self.cast(value)
          return nil if value.nil?
  
          string_value = value.to_s
  
          unless ALLOWED_VALUES.include?(string_value)
            raise ArgumentError, "Invalid title: #{value.inspect}. Allowed values: #{ALLOWED_VALUES.join(', ')}"
          end
  
          string_value
        end
  
        # Helper method to get all enum values
        def self.values
          ALLOWED_VALUES
        end
      end
    end
  end
