module Unit
  module Types
    class BusinessVertical
      # Enum values as constants
      ADULT_ENTERTAINMENT_DATING_OR_ESCORT_SERVICES = 'AdultEntertainmentDatingOrEscortServices'
      ADVERTISING_OR_MARKETING = 'AdvertisingOrMarketing'
      AGRICULTURE_FORESTRY_FISHING_OR_HUNTING = 'AgricultureForestryFishingOrHunting'
      ARTS_ENTERTAINMENT_AND_RECREATION = 'ArtsEntertainmentAndRecreation'
      BUSINESS_SUPPORT_OR_BUILDING_SERVICES = 'BusinessSupportOrBuildingServices'
      CANNABIS = 'Cannabis'
      CONSTRUCTION = 'Construction'
      DIRECT_MARKETING_OR_TELEMARKETING = 'DirectMarketingOrTelemarketing'
      EDUCATIONAL_SERVICES = 'EducationalServices'
      FINANCIAL_SERVICES_CRYPTOCURRENCY = 'FinancialServicesCryptocurrency'
      FINANCIAL_SERVICES_DEBIT_COLLECTION_OR_CONSOLIDATION = 'FinancialServicesDebitCollectionOrConsolidation'
      FINANCIAL_SERVICES_MONEY_SERVICES_BUSINESS_OR_CURRENCY_EXCHANGE = 'FinancialServicesMoneyServicesBusinessOrCurrencyExchange'
      FINANCIAL_SERVICES_OTHER = 'FinancialServicesOther'
      FINANCIAL_SERVICES_PAYDAY_LENDING = 'FinancialServicesPaydayLending'
      GAMING_OR_GAMBLING = 'GamingOrGambling'
      HEALTH_CARE_AND_SOCIAL_ASSISTANCE = 'HealthCareAndSocialAssistance'
      HOSPITALITY_ACCOMMODATION_OR_FOOD_SERVICES = 'HospitalityAccommodationOrFoodServices'
      LEGAL_ACCOUNTING_CONSULTING_OR_COMPUTER_PROGRAMMING = 'LegalAccountingConsultingOrComputerProgramming'
      MANUFACTURING = 'Manufacturing'
      MINING = 'Mining'
      NUTRACEUTICALS = 'Nutraceuticals'
      PERSONAL_CARE_SERVICES = 'PersonalCareServices'
      PUBLIC_ADMINISTRATION = 'PublicAdministration'
      REAL_ESTATE = 'RealEstate'
      RELIGIOUS_CIVIC_AND_SOCIAL_ORGANIZATIONS = 'ReligiousCivicAndSocialOrganizations'
      REPAIR_AND_MAINTENANCE = 'RepairAndMaintenance'
      RETAIL_TRADE = 'RetailTrade'
      TECHNOLOGY_MEDIA_OR_TELECOM = 'TechnologyMediaOrTelecom'
      TRANSPORTATION_OR_WAREHOUSING = 'TransportationOrWarehousing'
      UTILITIES = 'Utilities'
      WHOLESALE_TRADE = 'WholesaleTrade'

      ALLOWED_VALUES = constants(false).map { |c| const_get(c) }.freeze

      def self.cast(value)
        return nil if value.nil?

        string_value = value.to_s

        unless ALLOWED_VALUES.include?(string_value)
          raise ArgumentError, "Invalid business vertical: #{value.inspect}. Allowed values: #{ALLOWED_VALUES.join(', ')}"
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

