class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :beginning_at, type: DateTime
  field :description, type: String
  mount_uploader :poster, PosterUploader

  belongs_to :game
  has_one :location, dependent: :destroy

  validates :beginning_at, presence: true

  scope :upcoming, -> { where(:beginning_at.gte => Time.zone.now).asc(:beginning_at) }
  scope :finished, -> { where(:beginning_at.lte => Time.zone.now).asc(:beginning_at) }
end
