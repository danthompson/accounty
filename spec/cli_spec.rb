require 'minitest/autorun'
require 'stringio'

require_relative '../lib/accounty/cli'

module Accounty

  describe CLI do
    describe '#run' do
      it 'writes each account number to the screen' do
        output = StringIO.new
        input = StringIO.new
        input <<  "    _  _     _  _  _  _  _ \n"
        input <<  "  | _| _||_||_ |_   ||_||_|\n"
        input <<  "  ||_  _|  | _||_|  ||_| _|\n"
        input <<  "                           \n"
        input <<  " _  _  _  _  _     _  _    \n"
        input <<  "|_||_|  ||_ |_ |_| _| _|  |\n"
        input <<  " _||_|  ||_| _|  | _||_   |\n"
        input <<  "                           \n"
        input.rewind

        CLI.new(input, output).run

        output.rewind

        assert_equal("123456789\n987654321\n", output.read)
      end
    end
  end

end
