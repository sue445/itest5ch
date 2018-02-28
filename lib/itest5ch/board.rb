module Itest5ch
  class Board
    BOARDS_URL = "http://itest.5ch.net/"

    # @!attribute [rw] url
    #   @return [String]
    attr_accessor :url

    # @!attribute [rw] name
    #   @return [String]
    attr_accessor :name

    extend HtmlMethods

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
  end
end
