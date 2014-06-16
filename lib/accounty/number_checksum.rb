module Accounty
  class NumberChecksum
    def initialize(account_number)
      @account_number = Integer(account_number)
    end

    def valid?
      return if @account_number.zero?

      checksum.zero?
    end

    private

    def checksum
      # (d1+2*d2+3*d3 +..+9*d9) mod 11 = 0

      incrementers = (2..digits.length)
      multipliers = digits.zip(incrementers).map { |a| a.compact.reduce(:+) }
      multipliers.reduce(:*) % 11
    end

    def digits
      @digits ||= begin
        number = @account_number
        digits = []
        while number > 0
          digits << number % 10
          number /= 10
        end
        digits
      end
    end
  end
end
