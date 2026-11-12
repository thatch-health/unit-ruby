module Unit
  class PinReset < APIResource
    path '/cards'

    attribute :status, Types::String

    def self.resources_path(id)
      "#{super(id)}/secure-data/pin/reset"
    end

    include ResourceOperations::Create
  end
end
