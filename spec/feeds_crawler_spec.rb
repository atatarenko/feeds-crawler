require 'spec_helper'

RSpec.describe FeedsCrawler do
  describe '.crawl' do
    subject { described_class }

    context 'when processing rss urls' do
      let(:url) { 'spec/fixtures/rss_feed.xml' }
      let(:crawler) { instance_double(Crawlers::Rss, articles: []) }

      it 'recognize rss url' do
        allow_any_instance_of(Crawlers::Rss).to receive(:articles).and_return([])
        allow(Crawlers::Rss).to receive(:new).and_return(crawler)

        expect(Crawlers::Rss).to receive(:new).with(url)

        described_class.crawl(url)
      end

      context 'when passing rss url' do
        let(:url) { 'spec/fixtures/rss_feed.xml' }

        it 'crawls crawlers feeds articles' do
          expect(described_class.crawl(url)).to match_array(['Real Content'])
        end
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

    context 'when passing facebook url' do
      let(:url) { 'facebook.com/somegroup/' }
      let(:crawler) { instance_double(Crawlers::Facebook, articles: []) }

      it 'recognize facebook url' do
        allow_any_instance_of(Crawlers::Facebook).to receive(:articles).and_return([])
        allow(Crawlers::Facebook).to receive(:new).and_return(crawler)

        expect(Crawlers::Facebook).to receive(:new).with(url)

        described_class.crawl(url)
      end

      context 'when passing facebook url' do
        let(:url) { 'https://www.facebook.com/groups/1218045051560404/' }

        it 'crawls crawlers articles' do
          expect(described_class.crawl(url)).to match_array(['Real Content'])
        end
      end

      context 'when passing facebook urls' do
        it 'crawls posts content for each url'
      end
    end
  end
end
