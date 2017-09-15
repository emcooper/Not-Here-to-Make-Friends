RSpec.feature "Authenticated user visits their profile page" do
  context "they are part of multiple leagues" do
  it "sees links to active leagues only" do
      user = create(:user, :full_setup)
      active_league_1 = League.first
      active_league_2 = League.second
      retured_league = League.third

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      expect(page).to have_link(active_league_1.name)
      expect(page).to have_link(active_league_2.name)
      expect(page).to_not have_content(retured_league.name)
    end

    it "sees a table listing team roster contestants only with scores" do
      user = create(:user, :full_setup)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_path(user)

      expect(find('tr', text: Contestant.first.name)).to have_content(2)
      expect(find('tr', text: Contestant.second.name)).to have_content(4)
      expect(page).to_not have_content(Contestant.third.name)
      expect(page).to_not have_content(Contestant.fourth.name)
    end

    it "sees a table listing league teams with scores" do
      user = create(:user, :full_setup)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_path(user)

      expect(find('tr', text: Team.first.name)).to have_content(6)
      expect(find('tr', text: Team.second.name)).to have_content(4)
      expect(page).to_not have_content(Team.third.name)
    end
  end

  context "pre-drafting" do
    it "user sees prompt to draft and can navigate to draft room" do
      user = create(:user)
      season = create(:season)
      league = create(:league, season: season)
      user.teams << create(:team, league: league)
      create(:team, league: league)
      contestants = create_list(:contestant, 30)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/'
      save_and_open_page
      expect(page).to have_content("Visit the draft room to set your rankings!")
      expect(page).to have_link("Draft Room")

      click_on "Draft Room"
      expect(current_path).to eq("/teams/#{Team.first}/draft")
    end
  end
end
