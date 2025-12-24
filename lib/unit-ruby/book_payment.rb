module Unit
  class BookPayment < APIResource
    path '/payments'

    attribute :amount, Types::Integer
    attribute :description, Types::String
    attribute :transaction_summary_override, Types::String # Optional
    attribute :tags, Types::Hash # Optional
    attribute :idempotency_key, Types::String, factory: -> { SecureRandom.uuid } # Optional

    belongs_to :account
    belongs_to :counterparty_account

    include ResourceOperations::Create
  end
end
