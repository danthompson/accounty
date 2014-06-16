require_relative 'entry_parser'
require_relative 'number_checksum'

module Accounty
  class AccountNumber
    def initialize(entry)
      @entry = entry
    end

    def report
      "#{value} #{status}".strip
    end

    def value
      @value ||= EntryParser.new(@entry).call
    end

    def status
      case
      when illegible? then 'ILL'
      when invalid?   then 'ERR'
      end
    end

    def illegible?
      !!(value =~ /\?/)
    end

    def invalid?
      !NumberChecksum.new(value).valid?
    end
  end
end
