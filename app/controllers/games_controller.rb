class GamesController < ApplicationController
  respond_to :html
  before_action :authenticate_user!, except: [:index, :show]

  def index
  end

  def new
    @game = Game.new
    @game.events.build
  end

  def create
    @game = GameCreationService.create(game_attributes, current_user)
    respond_with @game
  end

  def edit
    @game = current_user.mastered_games.find(params[:id])
  end

  def update
    @game = current_user.mastered_games.find(params[:id])
    @game.update_attributes(game_attributes)
    respond_with @game
  end

  def destroy
    @game = current_user.mastered_games.find(params[:id])
    @game.destroy
    respond_with @game
  end

  private

  def game_attributes
    params.require(:game).permit(:title, :players_amount, 
                                 events_attributes: [:id, :_destroy, :beginning_at,
                                                     :description, :poster, :poster_cache,
                                                     :remove_poster])
  end
end
