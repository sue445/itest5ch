require "itest5ch/version"
require "hpricot"

module Itest5ch
  autoload :AssertMethods, "itest5ch/assert_methods"
  autoload :Board,         "itest5ch/board"
  autoload :BoardListPage, "itest5ch/board_list_page"
  autoload :Comment,       "itest5ch/comment"
  autoload :Config,        "itest5ch/config"
  autoload :HtmlMethods,   "itest5ch/html_methods"
  autoload :Thread,        "itest5ch/thread"

  # @return [Itest5ch::Config]
  def self.config
    @config ||= Config.new
  end
end
