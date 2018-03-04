module Itest5ch
  require "json"

  class Thread
    include HtmlMethods

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

    # @param subdomain      [String]
    # @param board          [String]
    # @param dat            [Integer]
    # @param name           [String]
    # @param comments_count [Integer]
    def initialize(subdomain:, board:, dat:, name: nil, comments_count: 0)
      @subdomain = subdomain
      @board = board
      @dat = dat
      @name = name
      @comments_count = comments_count
    end

    def ==(other)
      other.is_a?(Thread) && subdomain == other.subdomain && board == other.board &&
        dat == other.dat && name == other.name && comments_count == other.comments_count
    end

    def comments
      json_url = "http://itest.5ch.net/public/newapi/client.php?subdomain=#{subdomain}&board=#{board}&dat=#{dat}&rand=#{rand}"
      hash = JSON.parse(get_html(json_url))

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
