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
        attribute :entity_type, Types::String
        attribute :website, Types::String
        attribute :contact, Types::BusinessContact # Primary contact of the business
        attribute :officer, Types::CreateOfficer # Officer representing the business
        attribute :beneficial_owners, Types::Array # Beneficial owners of the business
        attribute :year_of_incorporation, Types::String # Year of incorporation of the business
        attribute :stock_symbol, Types::String
        attribute :industry, Types::Industry # Optional
        attribute :operating_address, Types::Address # Optional
        attribute :annual_revenue, Types::String # Optional, required if any officer or beneficial owner has non-US nationality
        attribute :number_of_employees, Types::String # Optional, required if any officer or beneficial owner has non-US nationality
        attribute :cash_flow, Types::String # Optional, required if any officer or beneficial owner has non-US nationality
        attribute :countries_of_operation, Types::Array # Optional, required if any officer or beneficial owner has non-US nationality
        attribute :ip, Types::String # Optional
        attribute :device_fingerprints, Types::Array # Optional
        attribute :banks, Types::Array # Optional

        belongs_to :customer, class_name: 'Unit::BusinessCustomer'
        belongs_to :application_form, class_name: 'Unit::ApplicationForm'

        include ResourceOperations::Find
        include ResourceOperations::List
        include ResourceOperations::Save

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