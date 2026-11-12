require 'spec_helper'

RSpec.describe Unit::PinReset do
  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:connection) do
    Unit::Connection.new.tap do |client|
      client.connection.adapter :test, stubs
    end
  end

  before do
    allow(described_class).to receive(:connection).and_return(connection)
  end

  after do
    stubs.verify_stubbed_calls
  end

  it 'posts a PIN reset for the given card ID and returns the PIN status' do
    stubs.post('/cards/1234/secure-data/pin/reset') do |request|
      expect(request.request_headers['Content-Type']).to eq('application/vnd.api+json')
      expect(request.request_headers['X-Test-Header']).to eq('test-value')
      expect(JSON.parse(request.body)).to eq(
        'data' => { 'type' => 'pinReset', 'attributes' => {} }
      )

      [200, { 'Content-Type' => 'application/json' }, {
        data: { type: 'pinStatus', id: '1234', attributes: { status: 'NotSet' } }
      }.to_json]
    end

    result = described_class.create(id: '1234', options: { headers: { 'X-Test-Header' => 'test-value' } })

    expect(result).to be_a(described_class)
    expect(result.id).to eq('1234')
    expect(result.status).to eq('NotSet')
    expect(result).not_to be_dirty
  end

  it 'raises an API error when the card cannot be reset' do
    stubs.post('/cards/5678/secure-data/pin/reset') do
      [404, { 'Content-Type' => 'application/json' }, {
        errors: [{ title: 'Card not found', status: '404' }]
      }.to_json]
    end

    expect { described_class.create(id: '5678') }.to raise_error(Unit::Error, /Card not found/)
  end
end
