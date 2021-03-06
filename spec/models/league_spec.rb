require 'rails_helper'

RSpec.describe League, type: :model do
  describe "relationships" do
    it {should have_many(:teams)}
    it {should belong_to(:season)}
  end

  describe "instance methods" do
    it "#team_of_user returns the team of the user" do
      user = create(:user, :full_setup)
      active_league = League.first
      user_team = Team.first
      expect(active_league.team_of_user(user)).to eq(user_team)
    end

    it "#owner_of returns the team that owns the contestant" do
      user = create(:user, :full_setup)
      league_1 = League.first
      contestant_1 = Contestant.first
      team_1 = Team.first

      expect(league_1.owner_of(contestant_1)).to eq(team_1)
    end

    it "#team_points returns collection of team names and points" do
      user = create(:user, :full_setup)
      league_1 = League.first
      contestant_1 = Contestant.first
      team_1 = Team.first
      team_2 = Team.second
      team_5 = Team.last

      expect(league_1.team_points.count).to eq(3)
      expect(league_1.team_points.first).to eq({name: team_1.name, points: [6, 0, 0, 0, 0, 0, 0, 0, 0, 0]})
      expect(league_1.team_points.second).to eq({name: team_2.name, points: [2, 2, 0, 0, 0, 0, 0, 0, 0, 0]})
      expect(league_1.team_points.third).to eq({name: team_5.name, points: [6, 10, 0, 0, 0, 0, 0, 0, 0, 0]})
    end
  end
end
