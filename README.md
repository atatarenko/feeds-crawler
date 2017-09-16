# Feeds Crawler

This gem allows to crawl news articles from RSS feeds. It realizes parallel execution for better performance and sanitize collected text from unnecessary HTML tags.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'feeds-crawler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install feeds-crawler

## Usage

```ruby
require 'feeds_crawler'

FeedsCrawler.crawl('rss_feed_url')
# => ["Article 1", "Article 2", "Article 3"]
```

It accepts as many RSS feeds as you want:
```ruby
my_favorite_rss_feeds = %w[
  first_rss_feed
  second_rss_feed
]

FeedsCrawler.crawl(my_favorite_rss_feeds)
# => ["Article from feed #1", "Article from feed #2"]
```
or:
```ruby
FeedsCrawler.crawl('first_rss_feed_url', 'second_rss_feed_url')
# => ["Article from feed #1", "Article from feed #2"]
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andrey17076/feeds-crawler.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
