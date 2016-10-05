class Club < ApplicationRecord
  CLUB_PIPELINE = Rails.application.secrets.streak_club_pipeline_key

  geocoded_by :address # This geocodes :address into :latitude and :longitude
  before_validation :geocode
  before_create :create_streak_box

  has_and_belongs_to_many :leaders

  validates_presence_of :name, :address, :latitude, :longitude

  private

  def create_streak_box
    unless self.streak_key
      resp = StreakClient::Box.create_in_pipeline(CLUB_PIPELINE, self.name)
      self.streak_key = resp[:key]
    end
  end
end
