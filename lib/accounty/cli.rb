require 'pathname'

require_relative 'entry'
require_relative 'account_number'

module Accounty
  class CLI
    def self.run(input, output, working_dir = '')
      cli = new(input, output, working_dir)
      cli.run
    end

    def initialize(input, output, working_dir = '')
      @input = input
      @output = output
      @working_dir = working_dir
    end

    def run
      @input.each do |file|
        next unless Pathname(file).exist?

        Pathname(file).open('r') do |entry_file|
          Pathname(report_filename(entry_file)).open('a') do |report_file|
            entry_file.each_slice(Entry::ROW_COUNT).with_index do |slice, index|
              capture_input_stats(file, index)

              entry = slice.map!(&:chomp)
              report = AccountNumber.new(entry).report

              report_file.puts(report)
              @output.puts(report)
            end
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

    def report_filename(original_filename)
      file = Pathname(original_filename)
      new_filename = "#{file.basename('.*')}-report#{file.extname}"

      Pathname(@working_dir).join(new_filename)
    end
  end
end
