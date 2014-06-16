require 'minitest/autorun'
require 'stringio'
require 'tmpdir'

require_relative '../lib/accounty/cli'

module Accounty

  describe CLI do
    let(:output) { StringIO.new }

    describe '.run' do
      it 'writes each account number to the screen' do
        input = [ 'spec/fixtures/entries-1.txt' ]

        Dir.mktmpdir do |working_dir|
          CLI.run(input, output, working_dir)
        end
        output.rewind

        assert_equal("000000000 ERR\n111111111 ERR\n", output.read)
      end
    end

    describe '#run' do
      it 'writes each account number to the screen' do
        input = [ 'spec/fixtures/entries-2.txt' ]

        Dir.mktmpdir do |working_dir|
          CLI.new(input, output, working_dir).run
        end
        output.rewind

        assert_equal("222222222\n333333333\n", output.read)
      end

      it 'writes an error message to the screen upon failure' do
        input = [ 'spec/fixtures/entries-with-error.txt' ]

        begin
          Dir.mktmpdir do |working_dir|
            CLI.new(input, output, working_dir).run
          end
        rescue SystemExit
        end

        output.rewind

        assert_match(/error/i, output.read)
      end

      it 'exits upon failure' do
        input = [ 'spec/fixtures/entries-with-error.txt' ]

        assert_raises(SystemExit) do
          Dir.mktmpdir do |working_dir|
            CLI.new(input, output, working_dir).run
          end
        end
      end

      it 'writes a report file' do
        input = [ 'spec/fixtures/entries-2.txt' ]

        Dir.mktmpdir do |working_dir|
          report = Pathname(working_dir).join('entries-2-report.txt')

          CLI.new(input, output, working_dir).run

          assert(report.exist?, 'report does not exist')
        end
      end

      it 'writes account number reports to a file' do
        input = [ 'spec/fixtures/entries-1.txt' ]

        Dir.mktmpdir do |working_dir|
          report = Pathname(working_dir).join('entries-1-report.txt')

          CLI.new(input, output, working_dir).run

          assert_equal("000000000 ERR\n111111111 ERR\n", report.read)
        end
      end

      it 'writes a report file for each input file' do
        input = [ 'spec/fixtures/entries-1.txt',
                  'spec/fixtures/entries-2.txt' ]

        Dir.mktmpdir do |working_dir|
          report_one = Pathname(working_dir).join('entries-1-report.txt')
          report_two = Pathname(working_dir).join('entries-2-report.txt')

          CLI.new(input, output, working_dir).run

          assert_equal("000000000 ERR\n111111111 ERR\n", report_one.read)
          assert_equal("222222222\n333333333\n", report_two.read)
        end
      end

      it 'ignores missing files' do
        input = [ 'spec/fixtures/does-not-exist.txt' ]

        Dir.mktmpdir do |working_dir|
          report = Pathname(working_dir).join('does-not-exist-report.txt')

          CLI.new(input, output, working_dir).run

          refute(report.exist?, 'report exists')
        end
      end
    end
  end

end
