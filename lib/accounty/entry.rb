module Accounty
  module Entry
    class InvalidFormat < StandardError; end

    CELL_WIDTH = 3

    CELL_HEIGHT = 3

    ROW_WIDTH = 27

    ROW_COUNT = 4

    UNRECOGNIZED_SEGMENT_CHAR = '?'

    ZERO_CHAR  = ' _ ' \
                 '| |' \
                 '|_|'.freeze

    ONE_CHAR   = '   ' \
                 '  |' \
                 '  |'.freeze

    TWO_CHAR   = ' _ ' \
                 ' _|' \
                 '|_ '.freeze

    THREE_CHAR = ' _ ' \
                 ' _|' \
                 ' _|'.freeze

    FOUR_CHAR  = '   ' \
                 '|_|' \
                 '  |'.freeze

    FIVE_CHAR  = ' _ ' \
                 '|_ ' \
                 ' _|'.freeze

    SIX_CHAR   = ' _ ' \
                 '|_ ' \
                 '|_|'.freeze

    SEVEN_CHAR = ' _ ' \
                 '  |' \
                 '  |'.freeze

    EIGHT_CHAR = ' _ ' \
                 '|_|' \
                 '|_|'.freeze

    NINE_CHAR  = ' _ ' \
                 '|_|' \
                 ' _|'.freeze

    CHARACTER_MAP = {
      ZERO_CHAR  => 0,
      ONE_CHAR   => 1,
      TWO_CHAR   => 2,
      THREE_CHAR => 3,
      FOUR_CHAR  => 4,
      FIVE_CHAR  => 5,
      SIX_CHAR   => 6,
      SEVEN_CHAR => 7,
      EIGHT_CHAR => 8,
      NINE_CHAR  => 9,
    }.freeze
  end
end
