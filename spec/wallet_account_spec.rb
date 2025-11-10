require 'spec_helper'

RSpec.describe Unit::WalletAccount do
  let(:wallet_terms) { 'Terms and conditions for wallet account' }

  subject do
    described_class.new(
      wallet_terms: wallet_terms
    )
  end

  describe 'attributes' do
    it 'has required writable attributes' do
      expect(subject.wallet_terms).to eq wallet_terms
    end

    it 'has optional writable attributes' do
      account = described_class.new(
        wallet_terms: wallet_terms,
        tags: { key: 'value' }
      )

      expect(account.tags).to be_a(Unit::Types::Hash)
      expect(account.tags[:key]).to eq 'value'
    end

    it 'generates idempotency_key via factory' do
      account = described_class.new(
        wallet_terms: wallet_terms
      )

      expect(account.idempotency_key).to be_a(String)
      expect(account.idempotency_key.length).to be > 0
    end

    it 'has readonly attributes' do
      # These would be set when loading from API
      account = described_class.new(
        wallet_terms: wallet_terms
      )

      expect(account).to respond_to(:created_at)
      expect(account).to respond_to(:updated_at)
      expect(account).to respond_to(:name)
      expect(account).to respond_to(:routing_number)
      expect(account).to respond_to(:account_number)
      expect(account).to respond_to(:deposit_product)
      expect(account).to respond_to(:currency)
      expect(account).to respond_to(:balance)
      expect(account).to respond_to(:hold)
      expect(account).to respond_to(:available)
      expect(account).to respond_to(:freeze_reason)
      expect(account).to respond_to(:close_reason)
      expect(account).to respond_to(:fraud_status)
      expect(account).to respond_to(:data_status)
    end
  end

  describe '#resource_path' do
    it 'returns the resource path with id' do
      account = described_class.new(
        wallet_terms: wallet_terms
      )
      account.id = '123'

      expect(account.resource_path).to eq '/accounts/123'
    end
  end

  describe '#close' do
    let(:connection) { instance_double(Unit::Connection) }
    let(:response_body) do
      {
        id: '123',
        type: 'walletAccount',
        attributes: {
          close_reason: 'ByCustomer',
          status: 'Closed'
        }
      }
    end

    before do
      allow(described_class).to receive(:connection).and_return(connection)
      allow(connection).to receive(:post).and_return(response_body)
    end

    it 'calls the close endpoint with reason' do
      account = described_class.new(
        wallet_terms: wallet_terms
      )
      account.id = '123'

      account.close('ByCustomer')

      expect(connection).to have_received(:post).with(
        '/accounts/123/close',
        {
          data: {
            type: 'walletAccountClose',
            attributes: {
              reason: 'ByCustomer'
            }
          }
        }
      )
    end

    it 'updates the account with the response' do
      account = described_class.new(
        wallet_terms: wallet_terms
      )
      account.id = '123'

      account.close('ByCustomer')

      expect(account.close_reason).to eq 'ByCustomer'
    end

    it 'handles nil reason' do
      account = described_class.new(
        wallet_terms: wallet_terms
      )
      account.id = '123'

      account.close(nil)

      expect(connection).to have_received(:post).with(
        '/accounts/123/close',
        {
          data: {
            type: 'walletAccountClose',
            attributes: {}
          }
        }
      )
    end
  end

  describe '#freeze' do
    let(:connection) { instance_double(Unit::Connection) }
    let(:response_body) do
      {
        id: '123',
        type: 'walletAccount',
        attributes: {
          freeze_reason: 'Fraud',
          status: 'Frozen'
        }
      }
    end

    before do
      allow(described_class).to receive(:connection).and_return(connection)
      allow(connection).to receive(:post).and_return(response_body)
    end

    it 'calls the freeze endpoint with reason and reason_text' do
      account = described_class.new(
        wallet_terms: wallet_terms
      )
      account.id = '123'

      account.freeze('Fraud', 'Suspicious activity detected')

      expect(connection).to have_received(:post).with(
        '/accounts/123/freeze',
        {
          data: {
            type: 'walletAccountFreeze',
            attributes: {
              reason: 'Fraud',
              reasonText: 'Suspicious activity detected'
            }
          }
        }
      )
    end

    it 'updates the account with the response' do
      account = described_class.new(
        wallet_terms: wallet_terms
      )
      account.id = '123'

      account.freeze('Fraud', 'Suspicious activity detected')

      expect(account.freeze_reason).to eq 'Fraud'
    end

    it 'handles nil values with compact' do
      account = described_class.new(
        wallet_terms: wallet_terms
      )
      account.id = '123'

      account.freeze(nil, nil)

      expect(connection).to have_received(:post).with(
        '/accounts/123/freeze',
        {
          data: {
            type: 'walletAccountFreeze',
            attributes: {}
          }
        }
      )
    end
  end

  describe '#unfreeze' do
    let(:connection) { instance_double(Unit::Connection) }
    let(:response_body) do
      {
        id: '123',
        type: 'walletAccount',
        attributes: {
          freeze_reason: nil,
          status: 'Open'
        }
      }
    end

    before do
      allow(described_class).to receive(:connection).and_return(connection)
      allow(connection).to receive(:post).and_return(response_body)
    end

    it 'calls the unfreeze endpoint' do
      account = described_class.new(
        wallet_terms: wallet_terms
      )
      account.id = '123'

      account.unfreeze

      expect(connection).to have_received(:post).with(
        '/accounts/123/unfreeze'
      )
    end

    it 'updates the account with the response' do
      account = described_class.new(
        wallet_terms: wallet_terms
      )
      account.id = '123'

      account.unfreeze

      expect(account.freeze_reason).to be_nil
    end
  end

  describe '#reopen' do
    let(:connection) { instance_double(Unit::Connection) }
    let(:response_body) do
      {
        id: '123',
        type: 'walletAccount',
        attributes: {
          close_reason: nil,
          status: 'Open'
        }
      }
    end

    before do
      allow(described_class).to receive(:connection).and_return(connection)
      allow(connection).to receive(:post).and_return(response_body)
    end

    it 'calls the reopen endpoint' do
      account = described_class.new(
        wallet_terms: wallet_terms
      )
      account.id = '123'

      account.reopen

      expect(connection).to have_received(:post).with(
        '/accounts/123/reopen'
      )
    end

    it 'updates the account with the response' do
      account = described_class.new(
        wallet_terms: wallet_terms
      )
      account.id = '123'

      account.reopen

      expect(account.close_reason).to be_nil
    end
  end

  describe '#as_json_api' do
    it 'includes all non-readonly attributes' do
      result = subject.as_json_api

      expect(result).to include(:wallet_terms)
    end

    it 'excludes readonly attributes' do
      result = subject.as_json_api

      expect(result).not_to include(:created_at)
      expect(result).not_to include(:updated_at)
      expect(result).not_to include(:name)
      expect(result).not_to include(:routing_number)
      expect(result).not_to include(:account_number)
      expect(result).not_to include(:deposit_product)
      expect(result).not_to include(:currency)
      expect(result).not_to include(:balance)
      expect(result).not_to include(:hold)
      expect(result).not_to include(:available)
      expect(result).not_to include(:freeze_reason)
      expect(result).not_to include(:close_reason)
      expect(result).not_to include(:fraud_status)
      expect(result).not_to include(:data_status)
    end

    it 'includes optional attributes when present' do
      account = described_class.new(
        wallet_terms: wallet_terms,
        tags: { key: 'value' }
      )

      result = account.as_json_api
      expect(result).to include(:tags)
    end
  end
end

