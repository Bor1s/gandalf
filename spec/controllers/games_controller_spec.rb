require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  login_user

  before do
    Game.destroy_all
  end

  describe 'GET #index' do
    it 'renders template' do
      expect(get :index).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'renders template for registered users' do
      expect(get :new).to render_template(:new)
    end

    it 'does not render template without user' do
      sign_out controller.current_user
      expect(get :new).to redirect_to(new_user_session_path)
    end
  end

  describe 'POST #create' do
    it 'redirects to #show after game is successfuly created' do
      params = {game: {title: 'New game',
                       players_amount: 3,
                       events_attributes: [{beginning_at: Faker::Date.forward(1), description: 'Session 1'},
                                           {beginning_at: Faker::Date.forward(2), description: 'Session 2'}]}}
      expect(post :create, params).to redirect_to(game_path(Game.first))
      expect(Game.first.master).to eq controller.current_user
    end
  end

  describe 'PATCH #update' do
    it 'redirects to #show after game is successfuly updated' do
      game = FactoryGirl.create(:game_with_upcoming_events)

      params = {id: game.id, game: {title: "#{game.title} updated"}}
      expect(patch :update, params).to redirect_to(game_path(game))
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to #index after game is successfuly removed' do
      game = FactoryGirl.create(:game_with_upcoming_events)
      expect(delete :destroy, id: game.id).to redirect_to(games_path)
    end
  end
end
