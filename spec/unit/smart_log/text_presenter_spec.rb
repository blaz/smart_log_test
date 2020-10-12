# frozen_string_literal: true

require_relative '../../../lib/smart_log/text_presenter'
require_relative '../../../lib/smart_log/page_views'
require_relative '../../spec_helper'

RSpec.describe SmartLog::TextPresenter do
  let(:presenter) { described_class.new(counter) }
  let(:counter_class) { SmartLog::PageViews }

  context 'output' do
    let(:counter) do
      counter_class.new.tap do |c|
        c.record_view('/foo', '1.2.3.4')
        c.record_view('/foo', '1.2.3.4')
        c.record_view('/foo', '1.2.3.4')
        c.record_view('/foo', '1.2.3.6')
        c.record_view('/foo', '1.2.3.6')
        c.record_view('/bar', '1.2.3.4')
        c.record_view('/bar', '1.2.3.4')
        c.record_view('/bar', '1.2.3.5')
        c.record_view('/bar', '1.2.3.6')
      end
    end

    it 'should format the output correctly' do
      expected_output = <<~OUTPUT
        /foo 5 visits
        /bar 4 visits
        /bar 3 unique views
        /foo 2 unique views
      OUTPUT

      expect(presenter.print).to eq(expected_output)
    end
  end
end
