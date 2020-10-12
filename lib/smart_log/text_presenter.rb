# frozen_string_literal: true

module SmartLog
  class TextPresenter
    def initialize(counter)
      @counter = counter
    end

    def print
      buffer = String.new

      counter.sorted_by_views.each do |path, count|
        buffer << "#{path} #{count[:views]} visits\n"
      end

      counter.sorted_by_uniques.each do |path, count|
        buffer << "#{path} #{count[:uniques]} unique views\n"
      end

      buffer
    end

    private

    attr_reader :counter
  end
end
