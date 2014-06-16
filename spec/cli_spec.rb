require 'minitest/autorun'
require 'stringio'

require_relative '../lib/accounty/cli'

module Accounty

  describe CLI do
    let(:output) { StringIO.new }

    describe '.run' do
      it 'writes each account number to the screen' do
        input = [ 'spec/fixtures/entries-1.txt' ]

        CLI.run(input, output)
        output.rewind

        assert_equal("000000000 ERR\n111111111 ERR\n", output.read)
      end
    end

    describe '#run' do
      it 'writes each account number to the screen' do
        input = [ 'spec/fixtures/entries-2.txt' ]

        CLI.new(input, output).run

        output.rewind

        assert_equal("222222222\n333333333\n", output.read)
      end

      it 'writes an error message to the screen upon failure' do
        input = [ 'spec/fixtures/entries-with-error.txt' ]

        begin
          CLI.new(input, output).run
        rescue SystemExit
        end

        output.rewind

        assert_match(/error/i, output.read)
      end

      it 'exits upon failure' do
        input = [ 'spec/fixtures/entries-with-error.txt' ]

        assert_raises(SystemExit) { CLI.new(input, output).run }
      end
    end
  end

end
