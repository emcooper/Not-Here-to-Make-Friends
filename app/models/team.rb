class Team < ApplicationRecord
  belongs_to :league
  has_many :team_members
  has_many :users, through: :team_members
  has_many :team_contestants
  has_many :contestants, through: :team_contestants

  def season_points
    contestants.joins(actions: :play).sum("point_value * count")
  end
end
