class GamesController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!, except: [:index, :show]

  def index
    #TODO Create service
    @events = Event.upcoming.asc('beginning_at')
  end

  def show
    @game = Game.find(params[:id])
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

  def enroll
    @game = Game.find(params[:id])
    respond_with @game do |format|
      @game.subscribe(current_user)
      format.html {redirect_to game_path(@game)}
    end
  end

  def unenroll
    @game = Game.find(params[:id])
    @game.redeem(current_user) unless current_user.creator?(@game)
    respond_with @game do |format|
      format.html {redirect_to game_path(@game)}
    end
  end

  private

  def game_attributes
    params.require(:game).permit(:title, :players_amount, :game_system_id,
                                 events_attributes: [:id, :_destroy, :beginning_at,
                                                     :description, :poster, :poster_cache,
                                                     :remove_poster])
  end
end
