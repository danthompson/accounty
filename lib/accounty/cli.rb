require 'pathname'

require_relative 'entry'
require_relative 'account_number'

module Accounty
  class CLI
    def self.run(input, output)
      cli = new(input, output)
      cli.run
    end

    def initialize(input, output)
      @input = input
      @output = output
    end

    def run
      @input.each do |file|
        next unless Pathname(file).exist?

        Pathname(file).open('r') do |entry_file|
          entry_file.each_slice(Entry::ROW_COUNT).with_index do |slice, index|
            capture_input_stats(file, index)

            entry = slice.map!(&:chomp)
            account_number = AccountNumber.new(entry)

            @output.puts(account_number.report)
          end
        end

      end
    rescue Entry::InvalidFormat => ex
      @output.puts("ERROR: #{ex.message}: [#{filename}:#{lineno}]")
      exit(1)
    end

    private

    attr_accessor :filename, :lineno

    def capture_input_stats(file, index)
      self.filename = file
      self.lineno = (index * Entry::ROW_COUNT) + 1
    end
  end
end
