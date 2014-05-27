module Groonga
  module Command
    class Base
      attr_reader :prefix
      def initialize(prefix, name, pair_arguments, ordered_arguments=[])
        @prefix = prefix
        @name = name
        @arguments = construct_arguments(pair_arguments, ordered_arguments)
        @original_format = nil
        @original_source = nil
      end

      def to_uri_format
        Format::URI.new(@prefix, @name, @arguments).path
      end
    end
  end
end
