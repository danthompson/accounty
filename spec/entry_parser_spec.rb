require 'minitest/autorun'

require_relative '../lib/accounty/entry_parser'

module Accounty

  describe EntryParser do
    describe '#call' do
      it 'returns an account number' do
        entry = [ "    _  _     _  _  _  _  _ ",
                  "  | _| _||_||_ |_   ||_||_|",
                  "  ||_  _|  | _||_|  ||_| _|",
                  "                           ", ]

        parser = EntryParser.new(entry)

        assert_equal('123456789', parser.call)
      end

      it 'returns an account number with markers for unrecognized segments' do
        expected = "86110%%36".gsub(/%/, Entry::UNRECOGNIZED_SEGMENT_CHAR)
        entry = [ " _  _        _     _  _  _ ",
                  "|_||_   |  || || |  | _||_ ",
                  "|_||_|  |  ||_|  | _| _||_|",
                  "                           ", ]

        account_number = EntryParser.new(entry).call

        assert_equal(expected, account_number)
      end

      it 'raises an exception for incorrect row count' do
        entry = [ "  | _| _||_||_ |_   ||_||_|",
                  "  ||_  _|  | _||_|  ||_| _|",
                  "                           ", ]

        ex = assert_raises(Entry::InvalidFormat) {
          EntryParser.new(entry).call
        }

        assert_match(/incorrect row count/i, ex.message)
      end

      it 'raises an exception for incorrect row width' do
        entry = [ "    _  _     _  _  _  _ ",
                  "  | _| _||_||_ |_   ||_|",
                  "  ||_  _|  | _||_|  ||_|",
                  "                        ", ]

        ex = assert_raises(Entry::InvalidFormat) {
          EntryParser.new(entry).call
        }

        assert_match(/incorrect row width/i, ex.message)
      end

      it 'raises an exception for missing last row marker' do
        entry = [ "    _  _     _  _  _  _  _ ",
                  "  | _| _||_||_ |_   ||_||_|",
                  "  ||_  _|  | _||_|  ||_| _|",
                  "  ||_  _|  | _||_|  ||_| _|", ]

        ex = assert_raises(Entry::InvalidFormat) {
          EntryParser.new(entry).call
        }

        assert_match(/missing last row marker/i, ex.message)
      end
    end
  end

end
