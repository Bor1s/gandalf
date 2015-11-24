class SearchController < ApplicationController
  respond_to :js
  def index
    game_ids = SearchService.search(params[:q])
    games = Game.where(:id.in => game_ids).all
    @events = Event.where(:id.in => games.map {|g| g.event_ids}.flatten.uniq)
  end
end
