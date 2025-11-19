require 'spec_helper'

RSpec.describe Unit::Types::CreateOfficer do
  let(:full_name) { Unit::Types::FullName.new(first: 'John', last: 'Doe') }
  let(:title) { 'CEO' }
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
  let(:evaluation_params) { nil }
  let(:occupation) { nil }
  let(:annual_income) { nil }
  let(:source_of_income) { nil }

  subject do
    described_class.new(
      full_name: full_name,
      title: title,
      ssn: ssn,
      passport: nil,
      nationality: nil,
      date_of_birth: date_of_birth,
      address: address,
      phone: phone,
      email: email,
      evaluation_params: evaluation_params,
      occupation: occupation,
      annual_income: annual_income,
      source_of_income: source_of_income
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.full_name).to eq full_name
    expect(subject.title).to eq title
    expect(subject.ssn).to eq ssn
    expect(subject.passport).to be_nil
    expect(subject.nationality).to be_nil
    expect(subject.date_of_birth).to eq date_of_birth
    expect(subject.address).to eq address
    expect(subject.phone).to eq phone
    expect(subject.email).to eq email
    expect(subject.evaluation_params).to eq evaluation_params
    expect(subject.occupation).to eq occupation
    expect(subject.annual_income).to eq annual_income
    expect(subject.source_of_income).to eq source_of_income
  end

  describe 'validation' do
    it 'raises error if both SSN and passport are provided' do
      expect {
        described_class.new(
          full_name: full_name,
          title: title,
          ssn: ssn,
          passport: passport,
          nationality: nationality,
          date_of_birth: date_of_birth,
          address: address,
          phone: phone,
          email: email,
          evaluation_params: evaluation_params,
          occupation: occupation,
          annual_income: annual_income,
          source_of_income: source_of_income
        )
      }.to raise_error(ArgumentError, 'CreateOfficer requires either SSN or passport, but not both')
    end

    it 'raises error if neither SSN nor passport is provided' do
      expect {
        described_class.new(
          full_name: full_name,
          title: title,
          ssn: nil,
          passport: nil,
          nationality: nil,
          date_of_birth: date_of_birth,
          address: address,
          phone: phone,
          email: email,
          evaluation_params: evaluation_params,
          occupation: occupation,
          annual_income: annual_income,
          source_of_income: source_of_income
        )
      }.to raise_error(ArgumentError, 'CreateOfficer requires either SSN or passport')
    end

    it 'raises error if passport is provided without nationality' do
      expect {
        described_class.new(
          full_name: full_name,
          title: title,
          ssn: nil,
          passport: passport,
          nationality: nil,
          date_of_birth: date_of_birth,
          address: address,
          phone: phone,
          email: email,
          evaluation_params: evaluation_params,
          occupation: occupation,
          annual_income: annual_income,
          source_of_income: source_of_income
        )
      }.to raise_error(ArgumentError, 'CreateOfficer requires nationality when passport is provided')
    end

    it 'allows SSN without passport' do
      instance = described_class.new(
        full_name: full_name,
        title: title,
        ssn: ssn,
        passport: nil,
        nationality: nil,
        date_of_birth: date_of_birth,
        address: address,
        phone: phone,
        email: email,
        evaluation_params: evaluation_params,
        occupation: occupation,
        annual_income: annual_income,
        source_of_income: source_of_income
      )

      expect(instance.ssn).to eq ssn
      expect(instance.passport).to be_nil
    end

    it 'allows passport with nationality' do
      instance = described_class.new(
        full_name: full_name,
        title: title,
        ssn: nil,
        passport: passport,
        nationality: nationality,
        date_of_birth: date_of_birth,
        address: address,
        phone: phone,
        email: email,
        evaluation_params: evaluation_params,
        occupation: occupation,
        annual_income: annual_income,
        source_of_income: source_of_income
      )

      expect(instance.passport).to eq passport
      expect(instance.nationality).to eq nationality
      expect(instance.ssn).to be_nil
    end
  end

  describe '#self.cast' do
    let(:new_full_name) { Unit::Types::FullName.new(first: 'Jane', last: 'Smith') }
    let(:new_title) { 'COO' }
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
    let(:new_evaluation_params) { { key: 'value' } }
    let(:new_occupation) { 'Executive' }
    let(:new_annual_income) { 150000 }
    let(:new_source_of_income) { 'Employment' }

    it 'returns the value if it is already a Types::CreateOfficer instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'instantiates a new instance with the provided attributes (using SSN)' do
      instance = described_class.cast(
        {
          full_name: new_full_name,
          title: new_title,
          ssn: new_ssn,
          passport: nil,
          nationality: nil,
          date_of_birth: new_date_of_birth,
          address: new_address,
          phone: new_phone,
          email: new_email,
          evaluation_params: new_evaluation_params,
          occupation: new_occupation,
          annual_income: new_annual_income,
          source_of_income: new_source_of_income
        }
      )

      expect(instance.full_name).to eq new_full_name
      expect(instance.title).to eq new_title
      expect(instance.ssn).to eq new_ssn
      expect(instance.passport).to be_nil
      expect(instance.nationality).to be_nil
      expect(instance.date_of_birth).to eq new_date_of_birth
      expect(instance.address).to eq new_address
      expect(instance.phone).to eq new_phone
      expect(instance.email).to eq new_email
      expect(instance.evaluation_params).to eq new_evaluation_params
      expect(instance.occupation).to eq new_occupation
      expect(instance.annual_income).to eq new_annual_income
      expect(instance.source_of_income).to eq new_source_of_income
    end

    it 'instantiates a new instance with passport and nationality' do
      instance = described_class.cast(
        {
          full_name: new_full_name,
          title: new_title,
          ssn: nil,
          passport: new_passport,
          nationality: new_nationality,
          date_of_birth: new_date_of_birth,
          address: new_address,
          phone: new_phone,
          email: new_email,
          evaluation_params: new_evaluation_params,
          occupation: new_occupation,
          annual_income: new_annual_income,
          source_of_income: new_source_of_income
        }
      )

      expect(instance.full_name).to eq new_full_name
      expect(instance.title).to eq new_title
      expect(instance.ssn).to be_nil
      expect(instance.passport).to eq new_passport
      expect(instance.nationality).to eq new_nationality
      expect(instance.date_of_birth).to eq new_date_of_birth
      expect(instance.address).to eq new_address
      expect(instance.phone).to eq new_phone
      expect(instance.email).to eq new_email
      expect(instance.evaluation_params).to eq new_evaluation_params
      expect(instance.occupation).to eq new_occupation
      expect(instance.annual_income).to eq new_annual_income
      expect(instance.source_of_income).to eq new_source_of_income
    end

    it 'casts nested types from hashes with SSN' do
      instance = described_class.cast(
        {
          full_name: { first: 'Bob', last: 'Johnson' },
          title: 'CFO',
          ssn: '111222333',
          passport: nil,
          nationality: nil,
          date_of_birth: '1990-06-20',
          address: {
            street: '789 Pine St',
            city: 'London',
            state: 'England',
            postal_code: 'SW1A 1AA',
            country: 'UK'
          },
          phone: { country_code: '44', number: '2071234567' },
          email: 'bob.johnson@example.com'
        }
      )

      expect(instance.full_name).to be_a(Unit::Types::FullName)
      expect(instance.full_name.first).to eq 'Bob'
      expect(instance.full_name.last).to eq 'Johnson'
      expect(instance.title).to eq 'CFO'
      expect(instance.address).to be_a(Unit::Types::Address)
      expect(instance.address.street).to eq '789 Pine St'
      expect(instance.phone).to be_a(Unit::Types::Phone)
      expect(instance.phone.country_code).to eq '44'
      expect(instance.phone.number).to eq '2071234567'
      expect(instance.ssn).to eq '111222333'
      expect(instance.passport).to be_nil
    end

    it 'casts nested types from hashes with passport' do
      instance = described_class.cast(
        {
          full_name: { first: 'Bob', last: 'Johnson' },
          title: 'CFO',
          ssn: nil,
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
          email: 'bob.johnson@example.com'
        }
      )

      expect(instance.full_name).to be_a(Unit::Types::FullName)
      expect(instance.full_name.first).to eq 'Bob'
      expect(instance.full_name.last).to eq 'Johnson'
      expect(instance.title).to eq 'CFO'
      expect(instance.address).to be_a(Unit::Types::Address)
      expect(instance.address.street).to eq '789 Pine St'
      expect(instance.phone).to be_a(Unit::Types::Phone)
      expect(instance.phone.country_code).to eq '44'
      expect(instance.phone.number).to eq '2071234567'
      expect(instance.passport).to eq 'EF345678'
      expect(instance.nationality).to eq 'UK'
      expect(instance.ssn).to be_nil
    end
  end

  describe '#as_json_api' do
    it 'returns a hash with SSN when SSN is provided' do
      expect(subject.as_json_api).to eq(
        {
          full_name: full_name.as_json_api,
          title: title,
          ssn: ssn,
          date_of_birth: date_of_birth,
          address: address.as_json_api,
          phone: phone.as_json_api,
          email: email
        }
      )
    end

    it 'returns a hash with passport and nationality when passport is provided' do
      instance = described_class.new(
        full_name: full_name,
        title: title,
        ssn: nil,
        passport: passport,
        nationality: nationality,
        date_of_birth: date_of_birth,
        address: address,
        phone: phone,
        email: email,
        evaluation_params: evaluation_params,
        occupation: occupation,
        annual_income: annual_income,
        source_of_income: source_of_income
      )

      expect(instance.as_json_api).to eq(
        {
          full_name: full_name.as_json_api,
          title: title,
          passport: passport,
          nationality: nationality,
          date_of_birth: date_of_birth,
          address: address.as_json_api,
          phone: phone.as_json_api,
          email: email
        }
      )
    end

    context 'with optional attributes' do
      let(:evaluation_params) { { risk_level: 'low' } }
      let(:occupation) { 'Executive' }
      let(:annual_income) { 200000 }
      let(:source_of_income) { 'Employment' }

      it 'includes optional attributes when present' do
        result = subject.as_json_api
        expect(result[:evaluation_params]).to eq evaluation_params
        expect(result[:occupation]).to eq occupation
        expect(result[:annual_income]).to eq annual_income
        expect(result[:source_of_income]).to eq source_of_income
      end
    end
  end
end

