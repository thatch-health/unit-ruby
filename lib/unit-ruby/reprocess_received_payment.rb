module Unit
  class ReprocessReceivedPayment < APIResource
    path '/received-payments'

    def self.resources_path(id)
      "#{super(id)}/reprocess"
    end

    include ResourceOperations::Create
  end
end
