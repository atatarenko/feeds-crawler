require 'spec_helper'

RSpec.describe Crawlers::Rss do
  describe '#articles' do
    subject { described_class.new('url').articles }

    context 'when rss url is invalid' do
      before { allow(Kernel).to receive(:open).and_raise(Errno::ENOENT) }

      it { is_expected.to be_empty }
    end

    context 'when rss url leads to error page' do
      before { allow(Kernel).to receive(:open).and_raise(OpenURI::HTTPError) }

      it { is_expected.to be_empty }
    end

    context 'when rss url leads to page with redirect' do
      before { allow(Kernel).to receive(:open).and_raise(RuntimeError) }

      it { is_expected.to be_empty }
    end

    context 'when something goes wrong even when page loads' do
      before do
        allow(Kernel).to receive_message_chain(:open, :read).and_raise(StandardError)
      end

      it { is_expected.to be_empty }
    end

    context 'when rss url is valid' do
      before do
        allow(Kernel).to receive_message_chain(:open, :read).and_return('page content')
      end

      context 'when page content is bad formatted markup' do
        before { allow(RSS::Parser).to receive(:parse).and_raise(RSS::Error) }

        it { is_expected.to be_empty }
      end

      context 'when page content is not rss feed' do
        before { allow(RSS::Parser).to receive(:parse).and_return(nil) }

        it { is_expected.to be_empty }
      end

      context 'when page content is real rss feed' do
        let(:feed_items) { [instance_double(RSS::Rss::Channel::Item, link: '')] }

        before do
          allow(RSS::Parser).to receive_message_chain(:parse, :items).and_return(feed_items)
          allow_any_instance_of(described_class).to receive(:extract_primary_content).and_return(feed_item_article)
        end

        context 'when link does not leads to page with content' do
          let(:feed_item_article) { '' }

          it { is_expected.to be_empty }
        end

        context 'when link leads to page with content' do
          let(:feed_item_article) { 'Content' }

          it { is_expected.to match_array([feed_item_article]) }
        end
      end
    end
  end
end
