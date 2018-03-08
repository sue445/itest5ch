module Itest5ch
  module HttpMethods
    require "open-uri"
    require "json"

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

    # @param url [String]
    # @param referer [String]
    #
    # @return [Hash]
    def get_json(url, referer: nil)
      JSON.parse(get_html(url, referer: referer))
    end
  end
end
