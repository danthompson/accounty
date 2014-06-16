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

      it 'returns the account number followed by ERR if invalid' do
        entry = [ " _  _     _  _        _  _ ",
                  "|_ |_ |_| _|  |  ||_||_||_ ",
                  "|_||_|  | _|  |  |  | _| _|",
                  "                           ", ]

        account_number = AccountNumber.new(entry)

        assert_match(/\sERR\Z/, account_number.report)
      end

      it 'returns the account number followed by ILL if illegible' do
        entry = [ " _  _        _     _  _  _ ",
                  "|_||_   |  || || |  | _||_ ",
                  "|_||_|  |  ||_|  | _| _||_|",
                  "                           ", ]

        account_number = AccountNumber.new(entry)

        assert_match(/\sILL\Z/, account_number.report)
      end
    end
  end

end
