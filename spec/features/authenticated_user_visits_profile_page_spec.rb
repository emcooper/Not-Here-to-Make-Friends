RSpec.feature "Authenticated user visits their profile page" do
  it "sees links to active leagues only" do
    user = create(:user, :with_2_active_and_2_retired_teams)
    active_leagues = League.where('name LIKE ?','%Active%')
    retired_leagues = League.where('name LIKE ?','%Retired%')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_path(user)
    
    expect(page).to have_button(active_leagues[0].name)
    expect(page).to have_button(active_leagues[1].name)
    expect(page).to_not have_content(retired_leagues[0].name)
    expect(page).to_not have_content(retired_leagues[1].name)
  end
end
