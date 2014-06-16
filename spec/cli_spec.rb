require 'minitest/autorun'
require 'stringio'

require_relative '../lib/accounty/cli'

module Accounty

  describe CLI do
    let(:output) { StringIO.new }
    let(:input) { StringIO.new }

    before do
      input <<  "    _  _     _  _  _  _  _ \n"
      input <<  "  | _| _||_||_ |_   ||_||_|\n"
      input <<  "  ||_  _|  | _||_|  ||_| _|\n"
      input <<  "                           \n"
      input <<  " _  _  _  _  _     _  _    \n"
      input <<  "|_||_|  ||_ |_ |_| _| _|  |\n"
      input <<  " _||_|  ||_| _|  | _||_   |\n"
      input <<  "                           \n"
      input.rewind
    end

    describe '.run' do
      it 'writes each account number to the screen' do
        CLI.run(input, output)
        output.rewind

        assert_equal("123456789\n987654321\n", output.read)
      end
    end

    describe '#run' do
      it 'writes each account number to the screen' do

        CLI.new(input, output).run

        output.rewind

        assert_equal("123456789\n987654321\n", output.read)
      end
    end
  end

end
