require "spec_helper"

# As a TV fanatic
# I want to add one of my favorite shows
# So that I can encourage others to binge watch it
#
# Acceptance Criteria:
# [x]  I must provide the title, network, and starting year, genre, and synopsis
# [x]  The genre must be one of the following: Action, Mystery,
#     Drama, Comedy, Fantasy
# [x]  If any of the above criteria is left blank, the form should be
#     re-displayed with the failing validation message

feature "user adds a new TV show" do

  scenario "successfully add a new show" do
    visit "/new"

    fill_in "Show Title:", with: "Friends"
    fill_in "Network", with: "NBC"
    fill_in "Start Year:", with: "1994"
    fill_in "Synopsis", with: "Six friends living in New York city."
    select "Comedy", from: "Genre"

    click_button "Submit"

    expect(page).to have_content "List of Shows"

    expect(page).to have_content "Friends on NBC"
  end

  scenario "fails to add a show with valid information and stays on the same page" do
    visit "/new"

    click_button "Submit"

    expect(page).to have_content "Please fill in all required fields"
  end
end
