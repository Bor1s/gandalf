class SearchController < ApplicationController
  def index
    result = SearchService.search(params[:q])
  end
end
