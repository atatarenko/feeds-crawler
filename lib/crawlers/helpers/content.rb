require 'ruby-readability'
require 'sanitize'

module Crawlers
  module Helpers
    module Content
      def extract_primary_content(html_text)
        content = Readability::Document.new(html_text).content
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
