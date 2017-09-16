require 'ruby-readability'
require 'sanitize'

module Crawlers
  module Helpers
    class Document
      def self.primary_content(html_text)
        content = Readability::Document.new(html_text).content
        sanitized_content = Sanitize.clean(content)
        remove_trailing_spaces(sanitized_content)
      end

      def self.remove_trailing_spaces(text)
        text.strip.gsub(/(?<=\n)\s+/, '')
      end
      private_class_method :remove_trailing_spaces
    end
  end
end
