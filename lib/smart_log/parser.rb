# frozen_string_literal: true

require_relative 'page_views'

module SmartLog
  NothingParsedError = Class.new(StandardError)

  class Parser
    def initialize(counter:)
      @counter = counter
    end

    def parse_line(line)
      path, address = line.split(' ', 2)
      @counter.record_view(path, address)
    end

    def counter
      raise NothingParsedError, "Nothing parsed, call `parse_line' first for each line" unless @counter.any?

      @counter
    end
  end
end
