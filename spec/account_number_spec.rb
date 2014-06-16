require 'minitest/autorun'

require_relative '../lib/accounty/account_number'

module Accounty

  describe AccountNumber do
    describe '#report' do
      it 'returns the account number' do
        entry = [ "    _  _     _  _  _  _  _ ",
                  "  | _| _||_||_ |_   ||_||_|",
                  "  ||_  _|  | _||_|  ||_| _|",
                  "                           ", ]
        account_number = AccountNumber.new(entry)

        assert_equal('123456789', account_number.report)
      end

      it 'returns the account number followed by INV if invalid' do
        entry = [ " _  _     _  _        _  _ ",
                  "|_ |_ |_| _|  |  ||_||_||_ ",
                  "|_||_|  | _|  |  |  | _| _|",
                  "                           ", ]

        account_number = AccountNumber.new(entry)

        assert_equal('664371495 INV', account_number.report)
      end
    end
  end

end
