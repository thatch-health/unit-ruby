module Unit
  module Types
    class SourceOfFunds
      SALES_OF_GOODS = 'SalesOfGoods'
      SALES_OF_SERVICES = 'SalesOfServices'
      CUSTOMER_PAYMENTS = 'CustomerPayments'
      INVESTMENT_CAPITAL = 'InvestmentCapital'
      BUSINESS_LOANS = 'BusinessLoans'
      OWNER_CONTRIBUTIONS = 'OwnerContributions'
      FRANCHISE_REVENUE = 'FranchiseRevenue'
      RENTAL_INCOME = 'RentalIncome'
      GOVERNMENT_CONTRACTS_OR_GRANTS = 'GovernmentContractsOrGrants'
      DONATIONS_OR_FUNDRAISING = 'DonationsOrFundraising'
      MEMBERSHIP_FEES_OR_SUBSCRIPTIONS = 'MembershipFeesOrSubscriptions'
      LICENSING_OR_ROYALTIES = 'LicensingOrRoyalties'
      COMMISSION_INCOME = 'CommissionIncome'
      IMPORT_EXPORT_REVENUE = 'ImportExportRevenue'
      CRYPTOCURRENCY_RELATED_ACTIVITY = 'CryptocurrencyRelatedActivity'
      SALARY_OR_WAGES = 'SalaryOrWages'
      BUSINESS_INCOME = 'BusinessIncome'
      INVESTMENT_INCOME = 'InvestmentIncome'
      RETIREMENT_SAVINGS = 'RetirementSavings'
      INHERITANCE = 'Inheritance'
      GIFT = 'Gift'
      SALE_OF_ASSETS = 'SaleOfAssets'
      LEGAL_SETTLEMENT = 'LegalSettlement'
      LOAN_PROCEEDS = 'LoanProceeds'

      ALLOWED_VALUES = constants(false).map { |c| const_get(c) }.freeze

      def self.cast(value)
        return nil if value.nil?

        string_value = value.to_s

        unless ALLOWED_VALUES.include?(string_value)
          raise ArgumentError, "Invalid source of funds: #{value.inspect}. Allowed values: #{ALLOWED_VALUES.join(', ')}"
        end

        string_value
      end

      def self.values
        ALLOWED_VALUES
      end
    end
  end
end
