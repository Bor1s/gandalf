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
    @game = Game.create(game_attributes)
    respond_with @game
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def game_attributes
    params.require(:game).permit(:title, :players_amount, events_attributes: [:id, :_destroy, :beginning_at, :description])
  end
end
