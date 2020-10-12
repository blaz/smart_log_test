# frozen_string_literal: true

module Helpers
  def asset_path(filename)
    File.expand_path(File.join(__dir__, 'assets', filename))
  end
end
