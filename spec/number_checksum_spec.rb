require 'minitest/autorun'

require_relative '../lib/accounty/number_checksum'

module Accounty

  describe NumberChecksum do
    describe '#valid?' do
      it 'returns true for a valid account number' do
        number_checksum = NumberChecksum.new('457507999')
        assert(number_checksum.valid?, 'invalid account number')
      end

      it 'returns false for an invalid account number' do
        number_checksum = NumberChecksum.new('664371495')
        refute(number_checksum.valid?, 'valid account number')
      end

      it 'returns false for an account number of zero' do
        number_checksum = NumberChecksum.new('000000000')
        refute(number_checksum.valid?, 'valid account number')
      end
    end
  end

end
