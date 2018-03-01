module Itest5ch
  class Board
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

    # Get all boards
    #
    # @return [Hash<String, Array<Itest5ch::Board>>] key: category name, value: boards
    def self.all
      doc = Hpricot(get_html(BOARDS_URL))

      doc.search("//div[@id='bbsmenu']//ul[@class='pure-menu-list']").each_with_object({}) do |ul, categories|
        next if ul["id"] == "history"

        category_name = ul.at("/li[@class='pure-menu-item pure-menu-selected']").inner_text.strip
        boards =
          ul.search("/li").
            select { |li| li["class"].include?("pure-menu-item") && !li["class"].include?("pure-menu-selected") }.
            each_with_object([]) do |li, _boards|

            url = URI.join(BOARDS_URL, li.at("/a")["href"]).to_s
            name = li.inner_text.strip

            _boards << Board.new(url, name: name)
          end

        categories[category_name] = boards
      end
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
      url = "#{BOARDS_URL}subback/#{board_name}"
      all.values.flatten.find { |board| board_name == board.name || url == board.url }
    end
  end
end
