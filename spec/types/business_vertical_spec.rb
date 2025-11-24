require 'spec_helper'

RSpec.describe Unit::Types::BusinessVertical do
  describe 'constants' do
    it 'defines all enum values as constants' do
      expect(described_class::CANNABIS).to eq 'Cannabis'
      expect(described_class::RETAIL_TRADE).to eq 'RetailTrade'
      expect(described_class::FINANCIAL_SERVICES_CRYPTOCURRENCY).to eq 'FinancialServicesCryptocurrency'
      expect(described_class::TECHNOLOGY_MEDIA_OR_TELECOM).to eq 'TechnologyMediaOrTelecom'
      expect(described_class::HEALTH_CARE_AND_SOCIAL_ASSISTANCE).to eq 'HealthCareAndSocialAssistance'
    end

  end

  describe '#self.cast' do
    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to be nil
    end

    it 'casts valid enum constant values' do
      expect(described_class.cast(described_class::CANNABIS)).to eq 'Cannabis'
      expect(described_class.cast(described_class::RETAIL_TRADE)).to eq 'RetailTrade'
      expect(described_class.cast(described_class::CONSTRUCTION)).to eq 'Construction'
    end

    it 'casts valid string values' do
      expect(described_class.cast('Cannabis')).to eq 'Cannabis'
      expect(described_class.cast('RetailTrade')).to eq 'RetailTrade'
      expect(described_class.cast('FinancialServicesCryptocurrency')).to eq 'FinancialServicesCryptocurrency'
      expect(described_class.cast('TechnologyMediaOrTelecom')).to eq 'TechnologyMediaOrTelecom'
    end

    it 'casts all allowed enum values' do
      described_class::ALLOWED_VALUES.each do |value|
        expect(described_class.cast(value)).to eq value
      end
    end

    it 'raises ArgumentError for invalid values' do
      expect { described_class.cast('InvalidValue') }.to raise_error(
        ArgumentError,
        /Invalid business vertical: "InvalidValue"/
      )
    end

    it 'raises ArgumentError with helpful message including allowed values' do
      expect { described_class.cast('NotAllowed') }.to raise_error(
        ArgumentError
      ) do |error|
        expect(error.message).to include('Invalid business vertical')
        expect(error.message).to include('NotAllowed')
        expect(error.message).to include('Allowed values')
      end
    end

    it 'converts non-string values to strings before validation' do
      # This should fail because numbers aren't valid enum values
      expect { described_class.cast(123) }.to raise_error(ArgumentError)
    end
  end

  describe '#self.values' do
    it 'returns all allowed enum values' do
      values = described_class.values
      expect(values).to be_an(Array)
      expect(values.length).to eq 31
      expect(values).to include('Cannabis')
      expect(values).to include('RetailTrade')
      expect(values).to include('FinancialServicesCryptocurrency')
    end

    it 'returns the same as ALLOWED_VALUES' do
      expect(described_class.values).to eq described_class::ALLOWED_VALUES
    end

    it 'returns a frozen array' do
      expect(described_class.values).to be_frozen
    end
  end
end

