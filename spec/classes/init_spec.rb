require 'spec_helper'
describe 'network' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with defaults for all parameters' do
        it { is_expected.to contain_class('network') }
        it { is_expected.to contain_file('interfaces config') }
      end

      context 'with restart set to true' do
        let(:params) do
          {
            restart: true,
          }
        end

        it { is_expected.to contain_exec('network restart') }
      end

      context 'with restart set to false' do
        let(:params) do
          {
            restart: false,
          }
        end

        it { is_expected.not_to contain_exec('network restart') }
      end
    end
  end
end
