# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative 'helpers'

def project_dir
  File.expand_path(File.join(__dir__, '..'))
end

RSpec.configure do |c|
  c.include Helpers
end
