class GameSystem
  include Mongoid::Document

  field :name, type: String

  has_many :games
end
