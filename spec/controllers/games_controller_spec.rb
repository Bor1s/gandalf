require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  login_user

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
end
