require 'spec_helper'

RSpec.describe Unit::Types::BeneficialOwner do
  let(:status) { 'Approved' }
  let(:full_name) { Unit::Types::FullName.new(first: 'John', last: 'Doe') }
  let(:ssn) { '123456789' }
  let(:passport) { 'AB123456' }
  let(:nationality) { 'US' }
  let(:date_of_birth) { '1980-01-01' }
  let(:address) do
    Unit::Types::Address.new(
      street: '123 Main St.',
      city: 'New York',
      state: 'NY',
      postal_code: '10001',
      country: 'US'
    )
  end
  let(:phone) { Unit::Types::Phone.new(country_code: '1', number: '5551234567') }
  let(:email) { 'john.doe@example.com' }
  let(:percentage) { 25.5 }
  let(:id_theft_score) { 750 }
  let(:occupation) { 'Business Owner' }
  let(:annual_income) { 200000 }
  let(:source_of_income) { 'Business' }

  subject do
    described_class.new(
      status: status,
      full_name: full_name,
      ssn: ssn,
      passport: passport,
      nationality: nationality,
      date_of_birth: date_of_birth,
      address: address,
      phone: phone,
      email: email,
      percentage: percentage,
      id_theft_score: id_theft_score,
      occupation: occupation,
      annual_income: annual_income,
      source_of_income: source_of_income
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.status).to eq status
    expect(subject.full_name).to eq full_name
    expect(subject.ssn).to eq ssn
    expect(subject.passport).to eq passport
    expect(subject.nationality).to eq nationality
    expect(subject.date_of_birth).to eq date_of_birth
    expect(subject.address).to eq address
    expect(subject.phone).to eq phone
    expect(subject.email).to eq email
    expect(subject.percentage).to eq percentage
    expect(subject.id_theft_score).to eq id_theft_score
    expect(subject.occupation).to eq occupation
    expect(subject.annual_income).to eq annual_income
    expect(subject.source_of_income).to eq source_of_income
  end

  describe '#self.cast' do
    let(:new_status) { 'Pending' }
    let(:new_full_name) { Unit::Types::FullName.new(first: 'Jane', last: 'Smith') }
    let(:new_ssn) { '987654321' }
    let(:new_passport) { 'CD789012' }
    let(:new_nationality) { 'CA' }
    let(:new_date_of_birth) { '1985-05-15' }
    let(:new_address) do
      Unit::Types::Address.new(
        street: '456 Oak Ave',
        city: 'Toronto',
        state: 'ON',
        postal_code: 'M5H 2N2',
        country: 'CA'
      )
    end
    let(:new_phone) { Unit::Types::Phone.new(country_code: '1', number: '5559876543') }
    let(:new_email) { 'jane.smith@example.com' }
    let(:new_percentage) { 30.0 }
    let(:new_id_theft_score) { 800 }
    let(:new_occupation) { 'Executive' }
    let(:new_annual_income) { 150000 }
    let(:new_source_of_income) { 'Employment' }

    it 'returns the value if it is already a Types::BeneficialOwner instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'instantiates a new instance with the provided attributes' do
      instance = described_class.cast(
        {
          status: new_status,
          full_name: new_full_name,
          ssn: new_ssn,
          passport: new_passport,
          nationality: new_nationality,
          date_of_birth: new_date_of_birth,
          address: new_address,
          phone: new_phone,
          email: new_email,
          percentage: new_percentage,
          id_theft_score: new_id_theft_score,
          occupation: new_occupation,
          annual_income: new_annual_income,
          source_of_income: new_source_of_income
        }
      )

      expect(instance.status).to eq new_status
      expect(instance.full_name).to eq new_full_name
      expect(instance.ssn).to eq new_ssn
      expect(instance.passport).to eq new_passport
      expect(instance.nationality).to eq new_nationality
      expect(instance.date_of_birth).to eq new_date_of_birth
      expect(instance.address).to eq new_address
      expect(instance.phone).to eq new_phone
      expect(instance.email).to eq new_email
      expect(instance.percentage).to eq new_percentage
      expect(instance.id_theft_score).to eq new_id_theft_score
      expect(instance.occupation).to eq new_occupation
      expect(instance.annual_income).to eq new_annual_income
      expect(instance.source_of_income).to eq new_source_of_income
    end

    it 'casts nested types from hashes' do
      instance = described_class.cast(
        {
          status: 'Rejected',
          full_name: { first: 'Bob', last: 'Johnson' },
          ssn: '111222333',
          passport: 'EF345678',
          nationality: 'UK',
          date_of_birth: '1990-06-20',
          address: {
            street: '789 Pine St',
            city: 'London',
            state: 'England',
            postal_code: 'SW1A 1AA',
            country: 'UK'
          },
          phone: { country_code: '44', number: '2071234567' },
          email: 'bob.johnson@example.com',
          percentage: 15.0,
          id_theft_score: 650,
          occupation: 'Consultant',
          annual_income: 100000,
          source_of_income: 'Contract'
        }
      )

      expect(instance.status).to eq 'Rejected'
      expect(instance.full_name).to be_a(Unit::Types::FullName)
      expect(instance.full_name.first).to eq 'Bob'
      expect(instance.full_name.last).to eq 'Johnson'
      expect(instance.address).to be_a(Unit::Types::Address)
      expect(instance.address.street).to eq '789 Pine St'
      expect(instance.phone).to be_a(Unit::Types::Phone)
      expect(instance.phone.country_code).to eq '44'
      expect(instance.phone.number).to eq '2071234567'
      expect(instance.percentage).to eq 15.0
      expect(instance.id_theft_score).to eq 650
    end
  end

  describe '#as_json_api' do
    it 'returns a hash with the correct attributes' do
      expect(subject.as_json_api).to eq(
        {
          status: status,
          full_name: full_name.as_json_api,
          ssn: ssn,
          passport: passport,
          nationality: nationality,
          date_of_birth: date_of_birth,
          address: address.as_json_api,
          phone: phone.as_json_api,
          email: email,
          percentage: percentage,
          id_theft_score: id_theft_score,
          occupation: occupation,
          annual_income: annual_income,
          source_of_income: source_of_income
        }
      )
    end
  end
end

