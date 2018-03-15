module Itest5ch
  require "securerandom"
  require "cgi"

  class Thread
    include HttpMethods
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

    # @!attribute [w] name
    attr_writer :name

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
    #     thread = Itest5ch::Thread.new(subdomain: "egg", board: "applism", dat: 1234567890)
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
    #
    # @raise [ArgumentError] `arg` is not either Hash and String
    def initialize(args)
      case args
      when Hash
        initialize_with_hash(args)
      when String
        initialize_with_string(args)
      else
        raise ArgumentError, "args is either Hash or String is required"
      end
    end

    # @param other [Itest5ch::Thread]
    #
    # @return [Boolean]
    def ==(other)
      other.is_a?(Thread) && subdomain == other.subdomain && board == other.board &&
        dat == other.dat && name == other.name && comments_count == other.comments_count
    end

    # @return [Array<Itest5ch::Comment>]
    def comments
      fetch_data["comments"].map do |comment|
        message = CGI.unescapeHTML(comment[6]).gsub("<br>", "\n").lines.map(&:strip).join("\n")
        number = comment[0]

        Comment.new(
          number:  number,
          name:    comment[1],
          mail:    comment[2],
          date:    time_at(comment[3].to_i),
          id:      comment[4],
          message: message,
          thread:  self,
        )
      end
    end

    # @return [String]
    def smartphone_url
      "http://itest.5ch.net/#{subdomain}/test/read.cgi/#{board}/#{dat}"
    end

    # @return [String]
    def pc_url
      "http://#{subdomain}.5ch.net/test/read.cgi/#{board}/#{dat}"
    end

    # @return [String]
    def name
      @name ||= fetch_name
    end

    # @return [String] thread name
    def fetch_name
      fetch_data["thread"][5]
    end

    private

      # @param hash [Hash]
      def initialize_with_hash(hash)
        assert_required_keys!(hash, :subdomain, :board, :dat)

        @subdomain      = hash[:subdomain]
        @board          = hash[:board]
        @dat            = hash[:dat]
        @name           = hash[:name]
        @comments_count = hash[:comments_count] || 0
      end

      # @param url [String]
      def initialize_with_string(url)
        if (m = url.match(%r{https?://itest\.5ch\.net/(.+)/test/read\.cgi/([^/]+)/([0-9]+)}))
          @subdomain = m[1]
          @board     = m[2]
          @dat       = m[3].to_i
          return
        end

        if (m = url.match(%r{https?://(.+)\.5ch\.net/test/read\.cgi/([^/]+)/([0-9]+)}))
          @subdomain = m[1]
          @board     = m[2]
          @dat       = m[3].to_i
          return
        end

        raise ArgumentError, "'#{url}' is invalid url format"
      end

      # @return [Hash]
      def fetch_data
        url = "http://itest.5ch.net/public/newapi/client.php?subdomain=#{subdomain}&board=#{board}&dat=#{dat}&rand=#{rand}"
        get_json(url, referer: smartphone_url)
      end

      # @return [String] random 10 char string
      def rand
        SecureRandom.hex(5)
      end

      # @param unixtime [Integer]
      #
      # @return [ActiveSupport::TimeWithZone] When `Time.zone` is initialized
      # @return [Time] When `Time.zone` is not initialized or without activesupport
      def time_at(unixtime)
        if Time.respond_to?(:zone) && Time.zone.respond_to?(:at)
          Time.zone.at(unixtime)
        else
          Time.at(unixtime)
        end
      end
  end
end
