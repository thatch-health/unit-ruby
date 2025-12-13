module Unit
    class BusinessDebitCard < APIResource
      path '/cards'
  
      attribute :full_name, Types::FullName # Full name of the cardholder
      attribute :date_of_birth, Types::Date # RFC3339 Date only (e.g. "2001-08-15").
      attribute :address, Types::Address # Address of the cardholder
      attribute :shipping_address, Types::Address # Optional, if not specified then address is used for shipping.
      attribute :phone, Types::Phone # Phone number of the cardholder
      attribute :email, Types::String # Email address of the cardholder
      attribute :design, Types::String # Optional. You may omit if only one card design. Please contact Unit if you need multiple card designs.
      attribute :additional_embossed_text, Types::String # Optional, up to 21 characters. Use for a second cardholder name, company name, or other data to be embossed on a card.
      attribute :idempotency_key, Types::String, factory: -> { SecureRandom.uuid } # Optional
      attribute :tags, Types::Hash # Optional
      attribute :limits, Types::Hash # Optional
      attribute :print_only_business_name, Types::Boolean # Optional, default is false.
      attribute :ssn, Types::String # Optional, SSN of the cardholder.
      attribute :passport, Types::String # Optional, passport number of the cardholder.
      attribute :nationality, Types::String # Optional, nationality of the cardholder.
      
      attribute :created_at, Types::DateTime, readonly: true
      attribute :updated_at, Types::DateTime, readonly: true
      attribute :last4_digits, Types::String, readonly: true
      attribute :expiration_date, Types::String, readonly: true
      attribute :bin, Types::String, readonly: true
      attribute :status, Types::String, readonly: true

      belongs_to :account, class_name: 'Unit::WalletAccount'
      belongs_to :customer, class_name: 'Unit::BusinessCustomer'

      include ResourceOperations::List
      include ResourceOperations::Create
      include ResourceOperations::Save
      include ResourceOperations::Find
  
      def save
        # unit doesn't recognize `idempotency_key` as a param for PATCH requests on this resource
        dirty_attributes.delete(:idempotency_key)
        super
      end
  
      def resource_path
        self.class.resource_path(id)
      end
  
      def report_stolen
        updated_resource = self.class.connection.post(
          "#{resource_path}/report-stolen"
        )
  
        update_resource_from_json_api(updated_resource)
      end
  
      def report_lost
        updated_resource = self.class.connection.post(
          "#{resource_path}/report-lost"
        )
  
        update_resource_from_json_api(updated_resource)
      end
  
      def close
        updated_resource = self.class.connection.post(
          "#{resource_path}/close"
        )
  
        update_resource_from_json_api(updated_resource)
      end
  
      def freeze
        updated_resource = self.class.connection.post(
          "#{resource_path}/freeze"
        )
  
        update_resource_from_json_api(updated_resource)
      end
  
      def unfreeze
        updated_resource = self.class.connection.post(
          "#{resource_path}/unfreeze"
        )
  
        update_resource_from_json_api(updated_resource)
      end
  
      def replace(shipping_address: nil)
        updated_resource = self.class.connection.post(
          "#{resource_path}/replace",
          {
            data: {
              type: "replaceCard",
              attributes: {
                shipping_address: shipping_address&.as_json_api,
              }.compact
            }
          }
        )
  
        update_resource_from_json_api(updated_resource)
      end
    end
  end
  