require 'rails_helper'

RSpec.describe SearchService, type: :service do
  subject { SearchService }

  before do
    allow_any_instance_of(SolrService).to receive(:search_games).with(anything()).and_return([])
  end

  describe '.search' do
    it 'triggers Solr to find data' do
      expect(subject.search('search text')).to eq []
    end
  end
end
