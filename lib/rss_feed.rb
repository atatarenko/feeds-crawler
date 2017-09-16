require 'rss'
require 'open-uri'
require 'ruby-readability'
require 'sanitize'

class RssFeed
  def initialize(rss_url)
    @rss_url = rss_url
  end

  def articles
    rss_feed_news.map(&method(:fetch_article))
  end

  private

  def rss_feed_news
    rss_feed = page_content(@rss_url)
    parse_feed(rss_feed)
  end

  def parse_feed(rss_feed)
    RSS::Parser.parse(rss_feed)&.items || []
  rescue RSS::Error
    []
  end

  def fetch_article(news)
    page_with_article = page_content(news.link)
    article = Readability::Document.new(page_with_article).content
    sanitize_article(article)
  end

  def sanitize_article(article)
    remove_trailing_spaces(Sanitize.clean(article))
  end

  def remove_trailing_spaces(article)
    article.strip.gsub(/(?<=\n)\s+/, '')
  end

  def page_content(page_url)
    open(page_url).read
  rescue SocketError, OpenURI::HTTPError
    ''
  end
end