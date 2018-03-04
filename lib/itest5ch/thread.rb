module Itest5ch
  class Thread
    include HtmlMethods
    include AssertMethods

    # @!attribute [rw] subdomain
    #   @return [String]
    attr_accessor :subdomain

    # @!attribute [rw] board
    #   @return [String]
    attr_accessor :board

    # @!attribute [rw] dat
    #   @return [Integer]
    attr_accessor :dat

    # @!attribute [rw] name
    #   @return [String]
    attr_accessor :name

    # @!attribute [rw] comments_count
    #   @return [Integer]
    attr_accessor :comments_count

    # @overload initialize(subdomain:, board:, dat:, name: nil, comments_count: 0)
    #   Set attributes
    #
    #   @param subdomain      [String]
    #   @param board          [String]
    #   @param dat            [Integer]
    #   @param name           [String]
    #   @param comments_count [Integer]
    #
    #   @example
    #     thread = Itest5ch::Thread.new(subdomain: "egg", board: "applism", dat: "1234567890")
    #
    # @overload initialize(url)
    #   Set thread url (PC or SmartPhone)
    #
    #   @param url [String] thread url
    #
    #   @example with SmartPhone url
    #     thread = Itest5ch::Thread.new("http://itest.5ch.net/egg/test/read.cgi/applism/1234567890")
    #
    #   @example with PC url
    #     thread = Itest5ch::Thread.new("http://egg.5ch.net/test/read.cgi/applism/1234567890")
    def initialize(args)
      case args
      when Hash
        assert_required_keys!(args, :subdomain, :board, :dat)

        @subdomain      = args[:subdomain]
        @board          = args[:board]
        @dat            = args[:dat]
        @name           = args[:name]
        @comments_count = args[:comments_count] || 0
      when String
        if (m = args.match(%r{http://itest\.5ch\.net/(.+)/test/read\.cgi/(.+)/([0-9]+)}))
          @subdomain = m[1]
          @board     = m[2]
          @dat       = m[3].to_i
          return
        end

        if (m = args.match(%r{http://(.+)\.5ch\.net/test/read\.cgi/(.+)/([0-9]+)}))
          @subdomain = m[1]
          @board     = m[2]
          @dat       = m[3].to_i
          return
        end

        raise ArgumentError, "'#{args}' is invalid url format"

      else
        raise ArgumentError, "args is either Hash or String is required"
      end
    end

    def ==(other)
      other.is_a?(Thread) && subdomain == other.subdomain && board == other.board &&
        dat == other.dat && name == other.name && comments_count == other.comments_count
    end

    def comments
      json_url = "http://itest.5ch.net/public/newapi/client.php?subdomain=#{subdomain}&board=#{board}&dat=#{dat}&rand=#{rand}"
      hash = get_json(json_url)

      hash["comments"].map do |comment|
        message = CGI.unescapeHTML(comment[6]).gsub("<br>", "\n").lines.map(&:strip).join("\n")

        Comment.new(
          number:  comment[0],
          name:    comment[1],
          mail:    comment[2],
          date:    Time.zone.at(comment[3].to_i),
          id:      comment[4],
          message: message,
        )
      end
    end

    private

      def rand
        SecureRandom.hex(5)
      end
  end
end
