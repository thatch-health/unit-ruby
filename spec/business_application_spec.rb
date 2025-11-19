require 'spec_helper'

RSpec.describe Unit::BusinessApplication do
  let(:name) { 'Acme Corp' }
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
  let(:state_of_incorporation) { 'DE' }
  let(:ein) { '123456789' }
  let(:entity_type) { 'Corporation' }
  let(:website) { 'https://acme.com' }
  let(:contact) do
    Unit::Types::BusinessContact.new(
      full_name: Unit::Types::FullName.new(first: 'John', last: 'Doe'),
      email: 'john.doe@acme.com',
      phone: phone
    )
  end
  let(:officer) do
    Unit::Types::CreateOfficer.new(
      full_name: Unit::Types::FullName.new(first: 'Jane', last: 'Smith'),
      title: 'CEO',
      ssn: '987654321',
      passport: 'AB123456',
      nationality: 'US',
      date_of_birth: '1980-01-01',
      address: address,
      phone: phone,
      email: 'jane.smith@acme.com'
    )
  end
  let(:beneficial_owners) do
    [
      Unit::Types::BeneficialOwner.new(
        full_name: Unit::Types::FullName.new(first: 'Bob', last: 'Johnson'),
        ssn: '111222333',
        passport: 'CD789012',
        nationality: 'US',
        date_of_birth: '1975-05-15',
        address: address,
        phone: phone,
        email: 'bob.johnson@acme.com',
        percentage: 25.0,
        id_theft_score: 750,
        occupation: 'Business Owner',
        annual_income: 200000,
        source_of_income: 'Business'
      )
    ]
  end
  let(:year_of_incorporation) { '2020' }
  let(:stock_symbol) { 'ACME' }

  subject do
    described_class.new(
      name: name,
      address: address,
      phone: phone,
      state_of_incorporation: state_of_incorporation,
      ein: ein,
      entity_type: entity_type,
      website: website,
      contact: contact,
      officer: officer,
      beneficial_owners: beneficial_owners,
      year_of_incorporation: year_of_incorporation,
      stock_symbol: stock_symbol
    )
  end

  describe 'attributes' do
    it 'has required attributes' do
      expect(subject.name).to eq name
      expect(subject.address).to eq address
      expect(subject.phone).to eq phone
      expect(subject.state_of_incorporation).to eq state_of_incorporation
      expect(subject.ein).to eq ein
      expect(subject.entity_type).to eq entity_type
      expect(subject.website).to eq website
      expect(subject.contact).to eq contact
      expect(subject.officer).to eq officer
      expect(subject.beneficial_owners.items).to eq beneficial_owners
      expect(subject.year_of_incorporation).to eq year_of_incorporation
      expect(subject.stock_symbol).to eq stock_symbol
    end

    it 'has optional attributes' do
      application = described_class.new(
        name: name,
        address: address,
        phone: phone,
        state_of_incorporation: state_of_incorporation,
        ein: ein,
        entity_type: entity_type,
        website: website,
        contact: contact,
        officer: officer,
        beneficial_owners: beneficial_owners,
        year_of_incorporation: year_of_incorporation,
        stock_symbol: stock_symbol,
        dba: 'Doing Business As',
        industry: Unit::Types::Industry::RETAIL,
        operating_address: address,
        annual_revenue: '1000000',
        number_of_employees: '50',
        cash_flow: '500000',
        countries_of_operation: ['US', 'CA'],
        ip: '192.168.1.1',
        device_fingerprints: ['fingerprint1', 'fingerprint2'],
        banks: ['bank1', 'bank2']
      )

      expect(application.dba).to eq 'Doing Business As'
      expect(application.industry).to eq 'Retail'
      expect(application.operating_address).to eq address
      expect(application.annual_revenue).to eq '1000000'
      expect(application.number_of_employees).to eq '50'
      expect(application.cash_flow).to eq '500000'
      expect(application.countries_of_operation.items).to eq ['US', 'CA']
      expect(application.ip).to eq '192.168.1.1'
      expect(application.device_fingerprints.items).to eq ['fingerprint1', 'fingerprint2']
      expect(application.banks.items).to eq ['bank1', 'bank2']
    end

    it 'has readonly attributes' do
      # These would be set when loading from API
      application = described_class.new(
        name: name,
        address: address,
        phone: phone,
        state_of_incorporation: state_of_incorporation,
        ein: ein,
        entity_type: entity_type,
        website: website,
        contact: contact,
        officer: officer,
        beneficial_owners: beneficial_owners,
        year_of_incorporation: year_of_incorporation,
        stock_symbol: stock_symbol
      )

      expect(application).to respond_to(:status)
      expect(application).to respond_to(:message)
      expect(application).to respond_to(:created_at)
      expect(application).to respond_to(:updated_at)
      expect(application).to respond_to(:archived)
    end

    it 'generates idempotency_key via factory' do
      application = described_class.new(
        name: name,
        address: address,
        phone: phone,
        state_of_incorporation: state_of_incorporation,
        ein: ein,
        entity_type: entity_type,
        website: website,
        contact: contact,
        officer: officer,
        beneficial_owners: beneficial_owners,
        year_of_incorporation: year_of_incorporation,
        stock_symbol: stock_symbol
      )

      expect(application.idempotency_key).to be_a(String)
      expect(application.idempotency_key.length).to be > 0
    end
  end

  describe '#resource_path' do
    it 'returns the resource path with id' do
      application = described_class.new(
        name: name,
        address: address,
        phone: phone,
        state_of_incorporation: state_of_incorporation,
        ein: ein,
        entity_type: entity_type,
        website: website,
        contact: contact,
        officer: officer,
        beneficial_owners: beneficial_owners,
        year_of_incorporation: year_of_incorporation,
        stock_symbol: stock_symbol
      )
      application.id = '123'

      expect(application.resource_path).to eq '/applications/123'
    end
  end

  describe '#cancel' do
    let(:connection) { instance_double(Unit::Connection) }
    let(:response_body) do
      {
        id: '123',
        type: 'businessApplication',
        attributes: {
          status: 'Cancelled',
          message: 'Application cancelled'
        }
      }
    end

    before do
      allow(described_class).to receive(:connection).and_return(connection)
      allow(connection).to receive(:post).and_return(response_body)
    end

    it 'calls the cancel endpoint with reason' do
      application = described_class.new(
        name: name,
        address: address,
        phone: phone,
        state_of_incorporation: state_of_incorporation,
        ein: ein,
        entity_type: entity_type,
        website: website,
        contact: contact,
        officer: officer,
        beneficial_owners: beneficial_owners,
        year_of_incorporation: year_of_incorporation,
        stock_symbol: stock_symbol
      )
      application.id = '123'

      application.cancel('User requested cancellation')

      expect(connection).to have_received(:post).with(
        '/applications/123/cancel',
        {
          data: {
            type: 'applicationCancel',
            attributes: {
              reason: 'User requested cancellation'
            }
          }
        }
      )
    end

    it 'updates the application with the response' do
      application = described_class.new(
        name: name,
        address: address,
        phone: phone,
        state_of_incorporation: state_of_incorporation,
        ein: ein,
        entity_type: entity_type,
        website: website,
        contact: contact,
        officer: officer,
        beneficial_owners: beneficial_owners,
        year_of_incorporation: year_of_incorporation,
        stock_symbol: stock_symbol
      )
      application.id = '123'

      application.cancel('User requested cancellation')

      expect(application.status).to eq 'Cancelled'
      expect(application.message).to eq 'Application cancelled'
    end

    it 'handles nil reason' do
      application = described_class.new(
        name: name,
        address: address,
        phone: phone,
        state_of_incorporation: state_of_incorporation,
        ein: ein,
        entity_type: entity_type,
        website: website,
        contact: contact,
        officer: officer,
        beneficial_owners: beneficial_owners,
        year_of_incorporation: year_of_incorporation,
        stock_symbol: stock_symbol
      )
      application.id = '123'

      application.cancel(nil)

      expect(connection).to have_received(:post).with(
        '/applications/123/cancel',
        {
          data: {
            type: 'applicationCancel',
            attributes: {}
          }
        }
      )
    end
  end

  describe '#as_json_api' do
    it 'includes all non-readonly attributes' do
      result = subject.as_json_api

      expect(result).to include(:name)
      expect(result).to include(:address)
      expect(result).to include(:phone)
      expect(result).to include(:state_of_incorporation)
      expect(result).to include(:ein)
      expect(result).to include(:entity_type)
      expect(result).to include(:website)
      expect(result).to include(:contact)
      expect(result).to include(:officer)
      expect(result).to include(:beneficial_owners)
      expect(result).to include(:year_of_incorporation)
      expect(result).to include(:stock_symbol)
    end

    it 'excludes readonly attributes' do
      result = subject.as_json_api

      expect(result).not_to include(:status)
      expect(result).not_to include(:message)
      expect(result).not_to include(:created_at)
      expect(result).not_to include(:updated_at)
      expect(result).not_to include(:archived)
    end

    it 'serializes nested types correctly' do
      result = subject.as_json_api

      expect(result[:address]).to be_a(Hash)
      expect(result[:phone]).to be_a(Hash)
      expect(result[:contact]).to be_a(Hash)
      expect(result[:officer]).to be_a(Hash)
      expect(result[:beneficial_owners]).to be_an(Array)
    end
  end
end

