# frozen_string_literal: true

require_relative '../../../lib/smart_log/page_views'
require_relative '../../../lib/smart_log/parser'
require_relative '../../spec_helper'

RSpec.describe SmartLog::Parser do
  let(:parser) { described_class.new(counter: counter) }
  let(:counter) { double('PageViews') }

  context 'error modes' do
    it 'should raise an error if nothing has been parse' do
      expect(counter).to receive(:any?).and_return(false)
      expect { parser.counter }.to raise_error SmartLog::NothingParsedError
    end
  end

  context 'parsing' do
    it 'should count a parsed line correctly' do
      expect(counter).to receive(:record_view).with('/foo', '1.2.3.4')
      parser.parse_line('/foo 1.2.3.4')
    end
  end

  context '#counter' do
    let(:counter) { SmartLog::PageViews.new }

    before { counter.record_view('/bar', '8.8.8.8') }

    it 'should return a PageViews object' do
      expect(parser.counter).to be_kind_of(SmartLog::PageViews)
    end

    it 'should return a non empty PageViews object' do
      expect(parser.counter.any?).to be(true)
    end
  end
end
