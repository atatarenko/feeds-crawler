require 'spec_helper'

RSpec.describe FeedsCrawler do
  describe '.crawl' do
    let(:rss_url) { 'spec/fixtures/rss_feed.xml' }

    subject { described_class.crawl(rss_url) }

    it 'crawls crawlers feeds articles' do
      is_expected.to match_array(['Real Content'])
    end

    context 'when passing an argument list' do
      let(:article) { 'article' }
      let(:rss_urls) { %w[first_url second_url] }

      before do
        allow_any_instance_of(Crawlers::Rss).to receive(:articles).and_return([article])
      end

      subject { described_class.crawl(*rss_urls).count }

      it 'crawls articles for each argument' do
        is_expected.to eq(rss_urls.length)
      end
    end
  end
end