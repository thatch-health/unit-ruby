module Unit
    module Types
        class CreateOfficer
            attr_reader :full_name, :title, :ssn, :passport, :nationality, :date_of_birth, :address, :phone, :email, :evaluation_params, :occupation, :annual_income, :source_of_income

            def initialize(
                full_name:,
                title:,
                ssn:,
                passport:,
                nationality:,
                date_of_birth:,
                address:,
                phone:,
                email:,
                evaluation_params: nil,
                occupation: nil,
                annual_income: nil,
                source_of_income: nil
            )
                if ssn && passport
                    raise ArgumentError, 'CreateOfficer requires either SSN or passport, but not both'
                end

                unless ssn || passport
                    raise ArgumentError, 'CreateOfficer requires either SSN or passport'
                end

                if passport && !nationality
                    raise ArgumentError, 'CreateOfficer requires nationality when passport is provided'
                end

                @full_name = full_name
                @title = title
                @ssn = ssn
                @passport = passport
                @nationality = nationality
                @date_of_birth = date_of_birth
                @address = address
                @phone = phone
                @email = email
                @evaluation_params = evaluation_params
                @occupation = occupation
                @annual_income = annual_income
                @source_of_income = source_of_income
            end

            def self.cast(val)
                return val if val.is_a? self
                return nil if val.nil?

                new(
                    full_name: FullName.cast(val[:full_name]),
                    title: Title.cast(val[:title]),
                    ssn: val[:ssn],
                    passport: val[:passport],
                    nationality: val[:nationality],
                    date_of_birth: val[:date_of_birth],
                    address: Address.cast(val[:address]),
                    phone: Phone.cast(val[:phone]),
                    email: val[:email],
                    evaluation_params: val[:evaluation_params],
                    occupation: val[:occupation],
                    annual_income: val[:annual_income],
                    source_of_income: val[:source_of_income]
                )
            end

            def as_json_api
                result = {
                    full_name: full_name&.as_json_api,
                    title: title,
                    date_of_birth: date_of_birth,
                    address: address&.as_json_api,
                    phone: phone&.as_json_api,
                    email: email,
                    evaluation_params: evaluation_params,
                    occupation: occupation,
                    annual_income: annual_income,
                    source_of_income: source_of_income
                }

                if ssn
                    result[:ssn] = ssn
                elsif passport
                    result[:passport] = passport
                    result[:nationality] = nationality
                end

                result.compact
            end
        end
    end
end
