module Accounty
  class EntryParser
    def initialize(entry)
      @entry = entry
    end

    def call
      segments = Hash.new { |h, k| h[k] = [] }
      character_map = {
        ' _ | ||_|' => 0,
        '     |  |' => 1,
        ' _  _||_ ' => 2,
        ' _  _| _|' => 3,
        '   |_|  |' => 4,
        ' _ |_  _|' => 5,
        ' _ |_ |_|' => 6,
        ' _   |  |' => 7,
        ' _ |_||_|' => 8,
        ' _ |_| _|' => 9,
      }

      @entry.take(3).each do |row|
        row.chars.take(27).each_slice(3).with_index do |*cells, key|
          segments[key].concat(cells.flatten)
        end
      end

      segments.collect { |_, cells| character_map[cells.join] }.join
    end
  end
end
