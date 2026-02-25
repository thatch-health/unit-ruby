module Unit
    class BusinessApplication < APIResource
        path '/applications'

        attribute :idempotency_key, Types::String, factory: -> { SecureRandom.uuid } # Optional
        attribute :tags, Types::Hash # Optional

        attribute :status, Types::String, readonly: true
        attribute :message, Types::String, readonly: true # Description of the application status
        attribute :created_at, Types::DateTime, readonly: true
        attribute :updated_at, Types::DateTime, readonly: true
        attribute :archived, Types::Boolean, readonly: true # Whether an application has been archived or not, occurs when corresponding customer is archived

        attribute :name, Types::String # Name of the business
        attribute :dba, Types::String # Optional
        attribute :address, Types::Address
        attribute :phone, Types::Phone
        attribute :state_of_incorporation, Types::String
        attribute :ein, Types::String
        attribute :entity_type, Types::String # LLC, Partnership, PubliclyTradedCorporation, PrivatelyHeldCorporation, NotForProfitOrganization, Estate, Trust, ForeignFinancialInstitution, DomesticFinancialInstitution, GovernmentEntityOrAgency, ReligiousOrganization, Charity
        attribute :website, Types::String # A valid website URL. null = business attests they have no website
        attribute :contact, Types::BusinessContact # Primary contact of the business
        attribute :officer, Types::CreateOfficer # Officer representing the business
        attribute :beneficial_owners, Types::Array # Beneficial owners of the business
        attribute :year_of_incorporation, Types::String # Year of incorporation of the business
        attribute :countries_of_operation, Types::Array # Array of ISO 3166-1 Alpha-2 country codes

        # V2 fields
        attribute :source_of_funds, Types::String # Primary source of funds of the business
        attribute :source_of_funds_description, Types::String # Required if source_of_funds is importExportRevenue or donationsOrFundraising
        attribute :business_industry, Types::BusinessIndustry # The industry of the business
        attribute :business_description, Types::String # Brief description of the business including main products/services and customers
        attribute :is_regulated, Types::Boolean # Is the business regulated by a government agency or financial regulator?
        attribute :regulator_name, Types::String # Required if is_regulated is true
        attribute :us_nexus, Types::Array # Array of UsNexus values: nature of business's ties to the U.S.
        attribute :account_purpose, Types::String # Primary purpose of the account
        attribute :account_purpose_detail, Types::String # Required for certain account_purpose values
        attribute :transaction_volume, Types::TransactionVolume # Expected monthly transaction volume (Business: LessThan10K, Between10KAnd50K, etc.)
        attribute :transaction_volume_description, Types::String # Required when transaction_volume is $1,000,001+
        attribute :stock_symbol, Types::String # Required if entity_type is PubliclyTradedCorporation
        attribute :stock_exchange_name, Types::String # Required if entity_type is PubliclyTradedCorporation

        attribute :operating_address, Types::Address # Optional
        attribute :ip, Types::String # Optional
        attribute :device_fingerprints, Types::Array # Optional
        attribute :banks, Types::Array # Optional

        belongs_to :customer, class_name: 'Unit::BusinessCustomer'
        belongs_to :application_form, class_name: 'Unit::ApplicationForm'

        include ResourceOperations::Find
        include ResourceOperations::List
        include ResourceOperations::Create

        def resource_path
            self.class.resource_path(id)
        end

        def cancel(reason)
            updated_resource = self.class.connection.post(
                "#{resource_path}/cancel",
                {
                    data: {
                        type: "applicationCancel",
                        attributes: {
                            reason: reason,
                        }.compact
                    }
                }
            )

            update_resource_from_json_api(updated_resource)
        end
    end
end