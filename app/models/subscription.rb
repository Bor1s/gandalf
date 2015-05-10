class Subscription
  USER_ROLE = {master: 1, player: 2}
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_role, type: Integer

  belongs_to :user
  belongs_to :game
end
