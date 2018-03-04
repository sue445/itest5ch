module Itest5ch
  class Comment
    # @!attribute number
    #   @return [Integer]
    attr_accessor :number

    # @!attribute name
    #   @return [String]
    attr_accessor :name

    # @!attribute mail
    #   @return [String]
    attr_accessor :mail

    # @!attribute date
    #   @return [Time]
    attr_accessor :date

    # @!attribute id
    #   @return [String]
    attr_accessor :id

    # @!attribute message
    #   @return [String]
    attr_accessor :message

    # @!attribute pc_url
    #   @return [String]
    attr_accessor :pc_url

    # @!attribute smartphone_url
    #   @return [String]
    attr_accessor :smartphone_url

    # @param number  [Integer]
    # @param name    [String]
    # @param mail    [String]
    # @param date    [Time]
    # @param id      [String]
    # @param message [String]
    def initialize(number:, name:, mail:, date:, id:, message:, pc_url: nil, smartphone_url: nil) # rubocop:disable Metrics/ParameterLists
      @number = number
      @name = name
      @mail = mail
      @date = date
      @id = id
      @message = message
      @pc_url = pc_url
      @smartphone_url = smartphone_url
    end

    # @return [Array<Integer>]
    def anchor_numbers
      numbers =
        message.scan(/[>＞]+([0-9０-９\-]+)/).map do |result|
          str = result.first.tr("０-９", "0-9")
          if (m = str.match(/([0-9]+)-([0-9]+)/))
            (m[1].to_i..m[2].to_i).to_a
          else
            str.to_i
          end
        end

      numbers.flatten.compact
    end

    alias_method :reply_numbers, :anchor_numbers
  end
end
