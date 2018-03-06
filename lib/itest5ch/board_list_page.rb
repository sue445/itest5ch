module Itest5ch
  class BoardListPage
    include HtmlMethods

    BOARDS_URL = "http://itest.5ch.net/".freeze

    # Get all boards
    #
    # @return [Hash<String, Array<Itest5ch::Board>>] key: category name, value: boards
    def all
      doc = Hpricot(get_html(BOARDS_URL))

      doc.search("//div[@id='bbsmenu']//ul[@class='pure-menu-list']").
        reject { |ul| ul["id"] == "history" }.each_with_object({}) do |ul, categories|

        category_name = ul.at("/li[@class='pure-menu-item pure-menu-selected']").inner_text.strip
        categories[category_name] = get_boards(ul)
      end
    end

    private

      def get_boards(ul)
        ul.search("/li").select { |li| board_element?(li) }.each_with_object([]) do |li, boards|
          url = URI.join(BOARDS_URL, li.at("/a")["href"]).to_s
          name = li.inner_text.strip

          boards << Board.new(url, name: name)
        end
      end

      def board_element?(li)
        return false unless li["class"].include?("pure-menu-item")
        return false if li["class"].include?("pure-menu-selected")

        true
      end
  end
end
