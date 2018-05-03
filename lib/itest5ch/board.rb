module Itest5ch
  class Board
    include HttpMethods

    # @!attribute [rw] url
    #   @return [String]
    attr_accessor :url

    # @!attribute [rw] name
    #   @return [String]
    attr_accessor :name

    # @param url  [String]
    # @param name [String]
    def initialize(url, name: nil)
      @url = url
      @name = name
    end

    # @param other [Itest5ch::Board]
    #
    # @return [Boolean]
    def ==(other)
      other.is_a?(Board) && url == other.url && name == other.name
    end

    # @return [Array<Itest5ch::Thread>]
    def threads
      hash = get_json(json_url, referer: url)
      hash["threads"].map do |thread|
        board, dat = thread[3].split("/", 2)
        Itest5ch::Thread.new(
          subdomain: thread[2],
          board:     board,
          dat:       dat.to_i,
          name:      thread[5],
        )
      end
    end

    # @return [String]
    def json_url
      if (m = url.match(%r{^https?://itest\.5ch\.net/subback/(.+?)/?$}))
        return "http://itest.5ch.net/subbacks/#{m[1]}.json"
      end

      if (m = url.match(%r{^https?://.+\.5ch\.net/(.+?)/?$}))
        return "http://itest.5ch.net/subbacks/#{m[1]}.json"
      end

      raise "Unknown url: #{url}"
    end

    # Get all boards
    #
    # @return [Hash<String, Array<Itest5ch::Board>>] key: category name, value: boards
    def self.all
      BoardListPage.new.all
    end

    # @param category_name [String]
    #
    # @return [Array<Itest5ch::Board>]
    def self.find_category_boards(category_name)
      all[category_name]
    end

    # @param board_name [String] name or id
    #
    # @return [Itest5ch::Board]
    def self.find(board_name)
      url = "#{Itest5ch::BoardListPage::BOARDS_URL}subback/#{board_name}"
      all.values.flatten.find { |board| board_name == board.name || url == board.url }
    end
  end
end
