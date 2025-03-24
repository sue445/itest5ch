module Itest5ch
  class BoardListPage
    include HttpMethods

    BOARDS_URL = "http://itest.5ch.net/".freeze

    # Get all boards
    #
    # @return [Hash<String, Array<Itest5ch::Board>>] key: category name, value: boards
    def all
      doc = Nokogiri::HTML.parse(get_html(BOARDS_URL))

      doc.search("//div[@id='bbsmenu']//ul[@class='pure-menu-list']").
        reject {|ul| ul["id"] == "history" }.each_with_object({}) do |ul, categories|
        category_node = ul.at_xpath("li[contains(@class, 'pure-menu-item') and contains(@class, 'pure-menu-selected')]")
        next unless category_node

        category_name = category_node.text.strip

        categories[category_name] = get_boards(ul)
      end
    end

    private

      def get_boards(ul)
        ul.xpath("li").select {|li| board_element?(li) }.each_with_object([]) do |li, boards|
          link = li.at_xpath("a")
          next unless link

          url = URI.join(BOARDS_URL, link["href"]).to_s
          name = li.text.strip

          boards << Board.new(url, name: name)
        end
      end

      def board_element?(li)
        klass = li["class"].to_s

        return false unless klass.include?("pure-menu-item")
        return false if klass.include?("pure-menu-selected")

        true
      end
  end
end
