module Unit
    class CardholderToken < APIResource
      path '/cards'
  
      attribute :scope, Types::String
      attribute :verification_token, Types::String
      attribute :verification_code, Types::String
      attribute :expires_in, Types::Integer

      attribute :token, Types::String, readonly: true
  
      def self.resources_path(id)
        "#{super(id)}/cardholder/token"
      end
  
      include ResourceOperations::Create
    end
end
