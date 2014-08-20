require 'uri'

module Groonga
  module Command
    module Format
      class URI
        def initialize(prefix, name, arguments)
          @prefix = prefix || 'd'
          @name = name
          @arguments = arguments
        end

        def path
          path = "/#{@prefix}/#{@name}"
          arguments = @arguments.dup
          output_type = arguments.delete(:output_type)
          path << ".#{output_type}" if output_type
          unless arguments.empty?
            sorted_arguments = arguments.sort_by do |name, _|
              name.to_s
            end

            uri_arguments = sorted_arguments.collect do |name, value|
              # "#{CGI.escape(name.to_s)}=#{CGI.escape(value)}"
              "#{::URI.encode(name.to_s)}=#{::URI.encode(value)}"
            end

            path << "?"
            path << uri_arguments.join("&")
          end
          path
        end
      end
    end
  end
end
