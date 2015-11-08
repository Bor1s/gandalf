require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #index' do
    before do
      allow_any_instance_of(SolrService).to receive(:search_games).and_return([])
    end

    it 'renders template' do
      expect(get :index).to render_template(:index)
    end

    it 'triggers SearchService' do
      expect(SearchService).to receive(:search).with('search text')
      get :index, q: 'search text'
    end
  end
end
