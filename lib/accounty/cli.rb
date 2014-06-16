require_relative 'entry'
require_relative 'entry_parser'

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
      @input.each_slice(Entry::ROW_COUNT) do |slice|
        entry = slice.map!(&:chomp)
        account_number = EntryParser.new(entry).call

        @output.puts(account_number)

      end
    rescue Entry::InvalidFormat => ex
      @output.puts("ERROR: #{ex.message}: [#{filename}:#{lineno}]")
      exit(1)
    end

    private

    def filename
      @input.filename if @input.respond_to?(:filename)
    end

    def lineno
      @input.file.lineno if @input.respond_to?(:file)
    end
  end
end
