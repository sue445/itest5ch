require "itest5ch/version"
require "itest5ch/html_methods"
require "itest5ch/board"
require "itest5ch/config"
require "hpricot"

module Itest5ch
  # @return [Itest5ch::Config]
  def self.config
    @config ||= Config.new
  end
end
