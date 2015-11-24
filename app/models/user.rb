class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include SolrService::MongoidHooks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  # === Application logic ===
  attr_accessor :current_password
  field :timezone, type: String
  field :nickname, type: String
  field :bio, type: String

  has_many :subscriptions, dependent: :delete

  def games
    Game.where(:id.in => subscriptions.where(user_id: self.id).map(&:game_id))
  end

  def mastered_games
    Game.where(:id.in => subscriptions.where(user_id: self.id, user_role: Subscription::USER_ROLE[:master]).map(&:game_id))
  end

  def playable_games
    Game.where(:id.in => subscriptions.where(user_id: self.id, user_role: Subscription::USER_ROLE[:player]).map(&:game_id))
  end

  # TODO Write specs
  def creator?(game)
    subscriptions.where(game_id: game.id, user_role: Subscription::USER_ROLE[:master]).first.present?
  end

  # NOTE Fileds to be indexed by Solr
  def solr_index_data
    data = {id: self.id}
    data[:usertext] = RSolr.solr_escape(self.nickname.to_s)
    data
  end
end
