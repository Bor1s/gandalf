class SearchService
  def self.search(text)
    Game.solr.search_games(text)
  end
end
