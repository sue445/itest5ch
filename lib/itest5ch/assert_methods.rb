module Itest5ch
  module AssertMethods
    # @param hash [Hash]
    # @param keys [Array<Symbol>]
    def assert_required_keys!(hash, *keys)
      keys.each do |key|
        assert_required!(key, hash[key])
      end
    end

    # @param name  [Symbol]
    # @param value [Object]
    #
    # @raise [ArgumentError]
    def assert_required!(name, value)
      raise ArgumentError, "#{name} is required" unless value
    end
  end
end
