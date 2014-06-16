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
    end
  end

end
