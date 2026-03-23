module Unit
  module Types
    class AccountPurpose
      PAYROLL_OR_DIRECT_DEPOSIT = 'PayrollOrDirectDeposit'
      PERSONAL_SAVINGS_OR_EMERGENCY_FUND = 'PersonalSavingsOrEmergencyFund'
      EVERYDAY_SPENDING = 'EverydaySpending'
      DOMESTIC_P2P_AND_BILL_PAY = 'DomesticP2PAndBillPay'
      INTERNATIONAL_REMITTANCES = 'InternationalRemittances'
      CASH_HEAVY_PERSONAL_INCOME = 'CashHeavyPersonalIncome'
      PROPERTY_PURCHASE_OR_INVESTMENT = 'PropertyPurchaseOrInvestment'
      EDUCATION_OR_STUDENT_USE = 'EducationOrStudentUse'
      TRUST_OR_ESTATE_DISTRIBUTIONS = 'TrustOrEstateDistributions'
      CRYPTOCURRENCY = 'Cryptocurrency'
      RETAIL_SALES_IN_PERSON = 'RetailSalesInPerson'
      ECOMMERCE_SALES = 'EcommerceSales'
      CASH_HEAVY_INCOME_AND_OPERATIONS = 'CashHeavyIncomeAndOperations'
      IMPORT_EXPORT_TRADE_OPERATIONS = 'ImportExportTradeOperations'
      PROFESSIONAL_SERVICES_NOT_HANDLING_FUNDS = 'ProfessionalServicesNotHandlingFunds'
      PROFESSIONAL_SERVICES_HANDLING_FUNDS = 'ProfessionalServicesHandlingFunds'
      HOLDING_OR_INVESTMENT_COMPANY_OPERATIONS = 'HoldingOrInvestmentCompanyOperations'
      PROPERTY_MANAGEMENT_OR_REAL_ESTATE_OPERATIONS = 'PropertyManagementOrRealEstateOperations'
      CHARITABLE_OR_NON_PROFIT_ORGANIZATION_OPERATIONS = 'CharitableOrNonProfitOrganizationOperations'
      CONSTRUCTION_AND_CONTRACTING_OPERATIONS = 'ConstructionAndContractingOperations'
      COMMERCIAL_CASH_OPERATIONS = 'CommercialCashOperations'
      FREIGHT_FORWARDING_OR_LOGISTICS_OPERATIONS = 'FreightForwardingOrLogisticsOperations'
      THIRD_PARTY_PAYMENT_PROCESSING = 'ThirdPartyPaymentProcessing'
      TECHNOLOGY_STARTUP_OPERATIONS = 'TechnologyStartupOperations'
      WHOLESALE_DISTRIBUTION_OPERATIONS = 'WholesaleDistributionOperations'
      FRANCHISE_OPERATION_OPERATIONS = 'FranchiseOperationOperations'
      HEALTHCARE_PROVIDER_OPERATIONS = 'HealthcareProviderOperations'
      EDUCATIONAL_INSTITUTION_OPERATIONS = 'EducationalInstitutionOperations'

      ALLOWED_VALUES = constants(false).map { |c| const_get(c) }.freeze

      def self.cast(value)
        return nil if value.nil?

        string_value = value.to_s

        unless ALLOWED_VALUES.include?(string_value)
          raise ArgumentError, "Invalid account purpose: #{value.inspect}. Allowed values: #{ALLOWED_VALUES.join(', ')}"
        end

        string_value
      end

      def self.values
        ALLOWED_VALUES
      end
    end
  end
end
