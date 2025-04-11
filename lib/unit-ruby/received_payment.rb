module Unit
  class ReceivedPayment < APIResource
    path '/received-payments'

    attribute :created_at, Types::DateTime, readonly: true
    attribute :status, Types::String, readonly: true
    attribute :was_advanced, Types::Boolean, readonly: true
    attribute :amount, Types::Integer, readonly: true
    attribute :completion_date, Types::Date, readonly: true
    attribute :company_name, Types::String, readonly: true
    attribute :counterparty_routing_number, Types::String, readonly: true
    attribute :description, Types::String, readonly: true
    attribute :trace_number, Types::String, readonly: true
    attribute :sec_code, Types::String, readonly: true
    attribute :return_cutoff_time, Types::DateTime, readonly: true
    attribute :can_be_reprocessed, Types::Boolean, readonly: true
    attribute :tags, Types::Hash, readonly: true

    belongs_to :account, class_name: 'Unit::DepositAccount'
    belongs_to :customer, class_name: 'Unit::IndividualCustomer' # Optional
    belongs_to :receive_payment_transaction, class_name: 'Unit::Transaction' # Optional
    belongs_to :payment_advance_transaction, class_name: 'Unit::Transaction' # Optional
    belongs_to :repay_payment_advance_transaction, class_name: 'Unit::Transaction' # Optional

    include ResourceOperations::Find
    include ResourceOperations::List
  end
end
