module Unit
    module Types
      class Industry
        # Enum values as constants
        RETAIL = 'Retail'
        WHOLESALE = 'Wholesale'
        RESTAURANTS = 'Restaurants'
        HOSPITALS = 'Hospitals'
        CONSTRUCTION = 'Construction'
        INSURANCE = 'Insurance'
        UNIONS = 'Unions'
        REAL_ESTATE = 'RealEstate'
        FREELANCE_PROFESSIONAL = 'FreelanceProfessional'
        OTHER_PROFESSIONAL_SERVICES = 'OtherProfessionalServices'
        ONLINE_RETAILER = 'OnlineRetailer'
        OTHER_EDUCATION_SERVICES = 'OtherEducationServices'

        ALLOWED_VALUES = constants(false).map { |c| const_get(c) }.freeze
  
        def self.cast(value)
          return nil if value.nil?
  
          string_value = value.to_s
  
          unless ALLOWED_VALUES.include?(string_value)
            raise ArgumentError, "Invalid industry: #{value.inspect}. Allowed values: #{ALLOWED_VALUES.join(', ')}"
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
  
  