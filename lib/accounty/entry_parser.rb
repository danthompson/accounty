require_relative 'entry'

module Accounty
  class EntryParser
    def initialize(entry)
      @entry = entry
    end

    def call
      validate_entry

      segments = Hash.new { |h, k| h[k] = [] }

      entry_rows.each do |row|
        row_cells(row).each do |*cells, key|
          segments[key].concat(cells.flatten)
        end
      end

      segments.collect do |_, cells|
        Entry::CHARACTER_MAP.fetch(cells.join, Entry::UNRECOGNIZED_SEGMENT_CHAR)
      end.join
    end

    private

    def entry_rows
      @entry.take(Entry::CELL_HEIGHT)
    end

    def row_cells(row)
      row.chars.take(Entry::ROW_WIDTH).each_slice(Entry::CELL_WIDTH).with_index
    end

    def validate_entry
      validate_row_count!
      validate_row_width!
      validate_last_row_marker!
    end

    def validate_row_count!
      return if @entry.count == Entry::ROW_COUNT
      raise Entry::InvalidFormat.new("Incorrect row count for entry")
    end

    def validate_row_width!
      return if @entry.all? { |row| row.length == Entry::ROW_WIDTH }
      raise Entry::InvalidFormat.new("Incorrect row width for entry")
    end

    def validate_last_row_marker!
      return if @entry.last =~ /\A\s+\Z/
      raise Entry::InvalidFormat.new("Missing last row marker for entry")
    end
  end
end
