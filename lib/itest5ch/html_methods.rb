module Itest5ch
  module HtmlMethods
    require "open-uri"

    # @param url [String]
    #
    # @return [String]
    def get_html(url)
      options = {}
      options["User-Agent"] = Itest5ch.config.user_agent if Itest5ch.config.user_agent

      open(url, options).read
    end
  end
end
