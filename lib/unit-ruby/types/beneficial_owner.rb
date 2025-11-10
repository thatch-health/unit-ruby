module Unit
    module Types
        class BeneficialOwner
            attr_reader :status, :full_name, :ssn, :passport, 
            :nationality, :date_of_birth, :address, :phone, :email, 
            :percentage, :id_theft_score, :occupation, :annual_income, :source_of_income

            def initialize(
                status:,
                full_name:,
                ssn:,
                passport:,
                nationality:,
                date_of_birth:,
                address:,
                phone:,
                email:,
                percentage:,
                id_theft_score:,
                occupation:,
                annual_income:,
                source_of_income:
            )
                @status = status
                @full_name = full_name
                @ssn = ssn
                @passport = passport
                @nationality = nationality
                @date_of_birth = date_of_birth
                @address = address
                @phone = phone
                @email = email
                @percentage = percentage
                @id_theft_score = id_theft_score
                @occupation = occupation
                @annual_income = annual_income
                @source_of_income = source_of_income
            end

            def self.cast(val)
                return val if val.is_a? self
                return nil if val.nil?

                new(
                    status: val[:status],
                    full_name: FullName.cast(val[:full_name]),
                    ssn: val[:ssn],
                    passport: val[:passport],
                    nationality: val[:nationality],
                    date_of_birth: val[:date_of_birth],
                    address: Address.cast(val[:address]),
                    phone: Phone.cast(val[:phone]),
                    email: val[:email],
                    percentage: val[:percentage],
                    id_theft_score: val[:id_theft_score],
                    occupation: val[:occupation],
                    annual_income: val[:annual_income],
                    source_of_income: val[:source_of_income]
                )
            end

            def as_json_api
                {
                    status: status,
                    full_name: full_name&.as_json_api,
                    ssn: ssn,
                    passport: passport,
                    nationality: nationality,
                    date_of_birth: date_of_birth,
                    address: address&.as_json_api,
                    phone: phone&.as_json_api,
                    email: email,
                    percentage: percentage,
                    id_theft_score: id_theft_score,
                    occupation: occupation,
                    annual_income: annual_income,
                    source_of_income: source_of_income
                }.compact
            end
        end
    end
end