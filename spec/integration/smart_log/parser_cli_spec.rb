# frozen_string_literal: true

require 'tempfile'
require 'open3'

require_relative '../../spec_helper'

parser_script = File.join(project_dir, 'bin', 'parser')

RSpec.describe 'SmartLog parser script invocation' do
  context 'given a missing or inaccessible logfile path' do
    context 'when not provided a logfile argument' do
      it 'returns the error code 1' do
        _, status = Open3.capture2e(parser_script)
        expect(status.exitstatus).to eq(1)
      end
    end

    context 'when not provided a readable logfile' do
      it 'returns the error code 2' do
        file = Tempfile.new('unreadable_file')
        File.chmod(0o000, file.path)

        begin
          _, status = Open3.capture2e(parser_script, file.path)
          expect(status.exitstatus).to eq(2)
        ensure
          file.close
          file.unlink
        end
      end
    end
  end

  context 'given a readable logfile path' do
    let(:logfile) { asset_path('logfile.txt') }
    let(:expected_output) do
      <<~OUTPUT
        / 4 visits
        /contact 3 visits
        /faq 1 visits
        /contact 3 unique views
        / 2 unique views
        /faq 1 unique views
      OUTPUT
    end

    it 'returns the correct and sorted output' do
      output, = Open3.capture2e(parser_script, logfile)
      expect(output).to eq(expected_output)
    end

    it 'returns the (successful) error code 0' do
      _, status = Open3.capture2e(parser_script, logfile)
      expect(status.exitstatus).to eq(0)
    end
  end
end
