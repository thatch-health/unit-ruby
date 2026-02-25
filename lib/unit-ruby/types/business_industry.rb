module Unit
  module Types
    class BusinessIndustry
      # Enum values as constants (V2 Business Application)
      # Retail
      GROCERY_STORES_OR_SUPERMARKETS = 'GroceryStoresOrSupermarkets'
      CONVENIENCE_STORES = 'ConvenienceStores'
      SPECIALTY_FOOD_RETAILERS = 'SpecialtyFoodRetailers'
      GAS_STATIONS_WITH_RETAIL = 'GasStationsWithRetail'
      GENERAL_MERCHANDISE_OR_DEPARTMENT_STORES = 'GeneralMerchandiseOrDepartmentStores'
      ONLINE_RETAIL_OR_ECOMMERCE = 'OnlineRetailOrECommerce'
      SUBSCRIPTION_AND_MEMBERSHIP_PLATFORMS = 'SubscriptionAndMembershipPlatforms'
      DIRECT_TO_CONSUMER_BRANDS = 'DirectToConsumerBrands'
      CANNABIS = 'Cannabis'

      # Financial Services
      BANKS_OR_CREDIT_UNIONS = 'BanksOrCreditUnions'
      FINTECH_OR_PAYMENT_PROCESSING = 'FinTechOrPaymentProcessing'
      INSURANCE_PROVIDERS = 'InsuranceProviders'
      INVESTMENT_ADVISORS_OR_BROKER_DEALERS = 'InvestmentAdvisorsOrBrokerDealers'
      LENDING_OR_MORTGAGE_COMPANIES = 'LendingOrMortgageCompanies'
      TREASURY_MANAGEMENT_PLATFORMS = 'TreasuryManagementPlatforms'
      PERSONAL_FINANCE_APPS_OR_AI_ASSISTANTS = 'PersonalFinanceAppsOrAIAssistants'
      RETIREMENT_PLANNING = 'RetirementPlanning'
      REAL_ESTATE_INVESTMENT_PLATFORMS = 'RealEstateInvestmentPlatforms'
      MONEY_SERVICE_BUSINESSES = 'MoneyServiceBusinesses'
      CRYPTOCURRENCY = 'Cryptocurrency'
      DEBT_COLLECTION = 'DebtCollection'
      PAYDAY_LENDING = 'PaydayLending'
      GAMBLING = 'Gambling'

      # Food & Agriculture
      FARMS_OR_AGRICULTURAL_PRODUCERS = 'FarmsOrAgriculturalProducers'
      FOOD_WHOLESALERS_OR_DISTRIBUTORS = 'FoodWholesalersOrDistributors'
      RESTAURANTS_OR_CAFES = 'RestaurantsOrCafes'
      BARS_OR_NIGHTCLUBS = 'BarsOrNightclubs'
      CATERING_SERVICES = 'CateringServices'
      FARMERS_MARKETS = 'FarmersMarkets'
      RESTAURANT_TECH_AND_POS_PROVIDERS = 'RestaurantTechAndPOSProviders'

      # Healthcare
      HOSPITALS_OR_CLINICS = 'HospitalsOrClinics'
      PHARMACIES = 'Pharmacies'
      MEDICAL_EQUIPMENT_SUPPLIERS = 'MedicalEquipmentSuppliers'
      BIOTECHNOLOGY_FIRMS = 'BiotechnologyFirms'
      HOME_HEALTH_SERVICES = 'HomeHealthServices'
      HEALTHCARE_STAFFING_PLATFORMS = 'HealthcareStaffingPlatforms'
      WELLNESS_AND_BENEFITS_PLATFORMS = 'WellnessAndBenefitsPlatforms'
      HEALTHCARE_AND_SOCIAL_ASSISTANCE = 'HealthcareAndSocialAssistance'

      # Professional Services
      LEGAL_SERVICES = 'LegalServices'
      ACCOUNTING_OR_AUDITING_FIRMS = 'AccountingOrAuditingFirms'
      CONSULTING_FIRMS = 'ConsultingFirms'
      MARKETING_OR_ADVERTISING_AGENCIES = 'MarketingOrAdvertisingAgencies'
      REAL_ESTATE_AGENTS_OR_PROPERTY_MANAGERS = 'RealEstateAgentsOrPropertyManagers'
      CORPORATE_SERVICES_AND_INCORPORATION = 'CorporateServicesAndIncorporation'
      HR_AND_WORKFORCE_MANAGEMENT_PLATFORMS = 'HRAndWorkforceManagementPlatforms'
      DIRECT_MARKETING_OR_TELEMARKETING = 'DirectMarketingOrTelemarketing'
      LEGAL_ACCOUNTING_CONSULTING_OR_COMPUTER_PROGRAMMING = 'LegalAccountingConsultingOrComputerProgramming'

      # Manufacturing
      CHEMICAL_MANUFACTURING = 'ChemicalManufacturing'
      ELECTRONICS_OR_HARDWARE_MANUFACTURING = 'ElectronicsOrHardwareManufacturing'
      AUTOMOTIVE_MANUFACTURING = 'AutomotiveManufacturing'
      CONSTRUCTION_MATERIALS = 'ConstructionMaterials'
      TEXTILES_OR_APPAREL = 'TextilesOrApparel'
      MINING = 'Mining'

      # Real Estate & Construction
      REAL_ESTATE = 'RealEstate'
      CONSTRUCTION = 'Construction'

      # Other
      TRANSPORTATION_OR_WAREHOUSING = 'TransportationOrWarehousing'
      WHOLESALE_TRADE = 'WholesaleTrade'
      BUSINESS_SUPPORT_OR_BUILDING_SERVICES = 'BusinessSupportOrBuildingServices'
      ESCORT_SERVICES = 'EscortServices'
      DATING_OR_ADULT_ENTERTAINMENT = 'DatingOrAdultEntertainment'

      ALLOWED_VALUES = constants(false).map { |c| const_get(c) }.freeze

      def self.cast(value)
        return nil if value.nil?

        string_value = value.to_s

        unless ALLOWED_VALUES.include?(string_value)
          raise ArgumentError, "Invalid business industry: #{value.inspect}. Allowed values: #{ALLOWED_VALUES.join(', ')}"
        end

        string_value
      end

      def self.values
        ALLOWED_VALUES
      end
    end
  end
end
