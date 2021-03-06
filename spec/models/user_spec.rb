require 'rails_helper'

RSpec.describe User, type: :model do
  subject {FactoryGirl.create(:user)}

  before do
    User.destroy_all
    Game.destroy_all
    subject.save
  end

  it '#mastered_games shows games with master role' do
    game = FactoryGirl.create(:game)
    game.subscribe(subject, role: :master)
    expect(subject.mastered_games.count).to eq 1
  end

  it '#playable_games shows games with player role' do
    game = FactoryGirl.create(:game)
    game.subscribe(subject)
    expect(subject.playable_games.count).to eq 1
  end

  context 'Solr' do
    it 'takes proper #solr_index_data' do
      expect(subject.solr_index_data).to eq({usertext: subject.nickname.to_s, id: subject.id})
    end
  end
end
