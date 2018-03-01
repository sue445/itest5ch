module Itest5ch
  class Thread
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
  end
end
