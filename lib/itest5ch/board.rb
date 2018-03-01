module Itest5ch
  require "json"

  class Board
    include HtmlMethods
    extend HtmlMethods

    BOARDS_URL = "http://itest.5ch.net/".freeze

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

    def ==(other)
      other.is_a?(Board) && url == other.url && name == other.name
    end

    # @return [Array<Itest5ch::Thread>]
    def threads
      json_url = "#{url.gsub("/subback/", "/subbacks/")}.json"
      hash = JSON.parse(get_html(json_url, referer: url))
      hash["threads"].map do |thread|
        board, dat = thread[3].split("/", 2)
        Itest5ch::Thread.new(
          subdomain:      thread[2],
          board:          board,
          dat:            dat.to_i,
          name:           thread[5],
          comments_count: thread[1],
        )
      end
    end

    # Get all boards
    #
    # @return [Hash<String, Array<Itest5ch::Board>>] key: category name, value: boards
    def self.all
      doc = Hpricot(get_html(BOARDS_URL))

      doc.search("//div[@id='bbsmenu']//ul[@class='pure-menu-list']").
        reject { |ul| ul["id"] == "history" }.each_with_object({}) do |ul, categories|

        category_name = ul.at("/li[@class='pure-menu-item pure-menu-selected']").inner_text.strip
        categories[category_name] = get_boards(ul)
      end
    end

    def self.get_boards(ul)
      ul.search("/li").
        select { |li| li["class"].include?("pure-menu-item") && !li["class"].include?("pure-menu-selected") }.
        each_with_object([]) do |li, boards|

        url = URI.join(BOARDS_URL, li.at("/a")["href"]).to_s
        name = li.inner_text.strip

        boards << Board.new(url, name: name)
      end
    end
    private_class_method :get_boards

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
      url = "#{BOARDS_URL}subback/#{board_name}"
      all.values.flatten.find { |board| board_name == board.name || url == board.url }
    end
  end
end
