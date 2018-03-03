module Itest5ch
  module HtmlMethods
    require "open-uri"

    # @param url [String]
    # @param referer [String]
    #
    # @return [String]
    def get_html(url, referer: nil)
      options = {}
      options["User-Agent"] = Itest5ch.config.user_agent if Itest5ch.config.user_agent
      options["Referer"] = referer if referer

      open(url, options).read
    end
  end
end
