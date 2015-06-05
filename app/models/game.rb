class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :players_amount, type: Integer, default: 0
  
  has_many :subscriptions, dependent: :delete
  has_many :events, dependent: :destroy
  belongs_to :game_system

  accepts_nested_attributes_for :events, allow_destroy: true

  validates :title, presence: true, uniqueness: true

  def subscribe(user, role: :player)
    subscriptions.create(user_id: user.id, user_role: Subscription::USER_ROLE[role]) unless user_subscribed?(user)
  end

  def user_subscribed?(user)
    subscriptions.where(user_id: user.id).exists?
  end

  def redeem(user)
    subscription = subscriptions.where(user_id: user.id).first
    subscriptions.delete(subscription) if subscription.present?
  end

  def master
    owner = subscriptions.where(user_role: Subscription::USER_ROLE[:master]).first
    owner and owner.user
  end

  def players
    player_subscriptions = subscriptions.where(user_role: Subscription::USER_ROLE[:player])
    User.where(:id.in => player_subscriptions.map(&:user_id))
  end

  def subscribers
    User.where(:id.in => subscriptions.map(&:user_id))
  end
end
