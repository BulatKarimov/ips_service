# frozen_string_literal: true

RSpec.describe IpsService::Repos::IpRepo do
  let(:ip) { Factory[:ip, enabled: is_enabled] }
  let(:is_enabled) { true }

  describe '#find' do
    subject { described_class.new.find(ip[:id]).one }

    specify do
      expect(subject).to eq({id: 1, ip_address: '8.8.8.8', enabled: true})
    end
  end
end
