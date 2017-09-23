module Crawlers
  class Facebook
    def initialize(facebook_url)
      @url = facebook_url
    end

    def articles
      doc = Nokogiri::HTML(open(@url))
      articles_description = doc.css('div').select do |div|
        div['class'] && div['class'].match?('userContent')
      end

      binding.pry
    end
  end
end
