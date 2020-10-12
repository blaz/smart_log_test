# frozen_string_literal: true

require 'set'

module SmartLog
  class PageViews
    attr_reader :data

    def initialize
      @data = Hash.new { |h, k| h[k] = { views: 0, uniques: 0 } }
      @seen_addresses = Hash.new { |h, k| h[k] = Set.new }
    end

    def record_view(path, address)
      data[path][:views] += 1

      return if seen_addresses[path].include?(address)

      seen_addresses[path].add(address)
      data[path][:uniques] += 1
    end

    def sorted_by_views
      data.sort { |a, b| b[1][:views] <=> a[1][:views] }
    end

    def sorted_by_uniques
      data.sort { |a, b| b[1][:uniques] <=> a[1][:uniques] }
    end

    def any?
      !data.empty?
    end

    private

    attr_reader :seen_addresses
  end
end
