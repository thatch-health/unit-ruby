require 'spec_helper'

RSpec.describe Unit::Types::BusinessContact do
  let(:full_name) { Unit::Types::FullName.new(first: 'John', last: 'Doe') }
  let(:email) { 'john.doe@example.com' }
  let(:phone) { Unit::Types::Phone.new(country_code: '1', number: '5551234567') }

  subject do
    described_class.new(
      full_name: full_name,
      email: email,
      phone: phone
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.full_name).to eq full_name
    expect(subject.email).to eq email
    expect(subject.phone).to eq phone
  end

  describe '#self.cast' do
    let(:new_full_name) { Unit::Types::FullName.new(first: 'Jane', last: 'Smith') }
    let(:new_email) { 'jane.smith@example.com' }
    let(:new_phone) { Unit::Types::Phone.new(country_code: '1', number: '5559876543') }

    it 'returns the value if it is already a Types::BusinessContact instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'instantiates a new instance with the provided attributes' do
      instance = described_class.cast(
        {
          full_name: new_full_name,
          email: new_email,
          phone: new_phone
        }
      )

      expect(instance.full_name).to eq new_full_name
      expect(instance.email).to eq new_email
      expect(instance.phone).to eq new_phone
    end

    it 'casts nested types from hashes' do
      instance = described_class.cast(
        {
          full_name: { first: 'Bob', last: 'Johnson' },
          email: 'bob.johnson@example.com',
          phone: { country_code: '44', number: '2071234567' }
        }
      )

      expect(instance.full_name).to be_a(Unit::Types::FullName)
      expect(instance.full_name.first).to eq 'Bob'
      expect(instance.full_name.last).to eq 'Johnson'
      expect(instance.email).to eq 'bob.johnson@example.com'
      expect(instance.phone).to be_a(Unit::Types::Phone)
      expect(instance.phone.country_code).to eq '44'
      expect(instance.phone.number).to eq '2071234567'
    end
  end

  describe '#as_json_api' do
    it 'returns a hash with the correct attributes' do
      expect(subject.as_json_api).to eq(
        {
          full_name: full_name.as_json_api,
          email: email,
          phone: phone.as_json_api
        }
      )
    end
  end
end

