require_relative 'entry'

module Accounty
  class EntryParser
    def initialize(entry)
      @entry = entry
    end

    def call
      segments = Hash.new { |h, k| h[k] = [] }

      entry_rows.each do |row|
        row_cells(row).each do |*cells, key|
          segments[key].concat(cells.flatten)
        end
      end

      segments.collect { |_, cells| Entry::CHARACTER_MAP[cells.join] }.join
    end

    private

    def entry_rows
      @entry.take(Entry::CELL_HEIGHT)
    end

    def row_cells(row)
      row.chars.take(Entry::ROW_WIDTH).each_slice(Entry::CELL_WIDTH).with_index
    end
  end
end
