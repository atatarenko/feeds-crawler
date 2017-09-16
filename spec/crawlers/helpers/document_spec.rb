require 'spec_helper'

RSpec.describe Crawlers::Helpers::Document do
  describe '.primary_content' do
    let(:html_text) { open('spec/fixtures/page_with_content.html').read }
    subject { described_class.primary_content(html_text) }

    it 'extracts real content of a document' do
      is_expected.to eq('Real Content')
    end

    context 'when real content still has markup element' do
      let(:markup) { '<div><p>Content</p></div>' }
      before { allow_any_instance_of(Readability::Document).to receive(:content).and_return(markup) }

      it 'removes any markup' do
        is_expected.to eq('Content')
      end
    end

    context 'when real content has trailing spaces' do
      let(:content) { "First line\n Second line" }
      before { allow(Sanitize).to receive(:clean).and_return(content) }

      it 'removes this spaces' do
        is_expected.to eq("First line\nSecond line")
      end
    end
  end
end