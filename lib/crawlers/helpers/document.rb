require 'ruby-readability'
require 'sanitize'

module Crawlers
  module Helpers
    class Document
      def initialize(text)
        @text = text
      end

      def primary_content
        content = Readability::Document.new(@text).content
        sanitized_content = Sanitize.clean(content)
        remove_trailing_spaces(sanitized_content)
      end

      private

      def remove_trailing_spaces(text)
        text.strip.gsub(/(?<=\n)\s+/, '')
      end
    end
  end
end
