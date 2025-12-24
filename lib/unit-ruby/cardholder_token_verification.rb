module Unit
    class CardholderTokenVerification < APIResource
      path '/cards'
  
      attribute :channel, Types::String
      attribute :verification_token, Types::String, readonly: true
  
      def self.resources_path(id)
        "#{super(id)}/cardholder/token/verification"
      end
  
      include ResourceOperations::Create
    end
end