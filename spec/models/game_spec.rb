require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { FactoryGirl.build(:game) }
  let(:user) {FactoryGirl.create(:user)}

  before do
    User.destroy_all
    Game.destroy_all
    subject.save
  end

  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:players_amount) }
  it { is_expected.to respond_to(:events) }
  it { is_expected.to respond_to(:subscriptions) }
  it { is_expected.to respond_to(:solr_index_data) }

  context '#subscribe' do
    it 'user with player role' do
      expect { subject.subscribe(user) }.to change(Subscription, :count).by(1)
    end

    it 'user with master role' do
      expect { subject.subscribe(user, role: :master) }.to change(Subscription, :count).by(1)
    end
  end

  it '#redeem removes user from subscribers' do
    subject.subscribe(user)
    expect { subject.redeem(user) }.to change(Subscription, :count).by(-1)
  end

  it '#master assumes to return game master' do
    subject.subscribe(user, role: :master)
    expect(subject.master).to eq user
  end

  it '#players assumes to return players' do
    subject.subscribe(user)
    expect(subject.players).to include(user)
  end

  it '#subscribers assumes to return all subscribers' do
    subject.subscribe(user)
    subject.subscribe(FactoryGirl.create(:user), role: :master)
    expect(subject.subscribers.count).to eq 2
  end

  it '#subscribed? check if user subscribed' do
    subject.subscribe(user)
    expect(subject.user_subscribed?(user)).to eq true
  end

  context 'Solr' do
    it 'takes proper #solr_index_data' do
      expect(subject.solr_index_data).to eq({ctext: subject.title, id: subject.id})
    end
  end
end
