# frozen_string_literal: true

require_relative 'parser'
require_relative 'text_presenter'

module SmartLog
  class ParserCLI
    class << self
      def run(logfile)
        verify_access!(logfile)

        parser = Parser.new(counter: PageViews.new)

        # Stream line by line, logfiles tend to be large
        File.foreach(logfile) do |line|
          parser.parse_line(line.strip)
        end

        print TextPresenter.new(parser.counter).print

        true
      end

      private

      def verify_access!(logfile)
        if !logfile || logfile == ''
          warn 'No logfile provided. Aborting!'
          exit(1)
        end

        return if FileTest.readable?(logfile)

        warn "Can't open `#{logfile}' for reading. Aborting!"
        exit(2)
      end
    end
  end
end
