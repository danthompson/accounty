require_relative 'entry'
require_relative 'entry_parser'

module Accounty
  class CLI
    def initialize(input, output)
      @input = input
      @output = output
    end

    def run
      @input.each_slice(Entry::ROW_COUNT) do |slice|
        entry = slice.map!(&:chomp)
        account_number = EntryParser.new(entry).call

        @output.puts(account_number)
      end
    end
  end
end
