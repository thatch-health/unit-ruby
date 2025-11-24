module Unit
    module Types
        class BusinessContact
            attr_reader :full_name, :email, :phone

            def initialize(
                full_name:,
                email:,
                phone:
            )
                @full_name = full_name
                @email = email
                @phone = phone
            end

            def self.cast(val)
                return val if val.is_a? self
                return nil if val.nil?

                new(
                    full_name: FullName.cast(val[:full_name]),
                    email: val[:email],
                    phone: Phone.cast(val[:phone])
                )
            end

            def as_json_api
                {
                    full_name: full_name&.as_json_api,
                    email: email,
                    phone: phone&.as_json_api
                }.compact
            end
        end
    end
end
