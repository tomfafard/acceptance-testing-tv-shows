require 'spec_helper'

# As an organized TV fanatic
# I want to receive an error message if I try to add the same show twice
# So that I don't have duplicate entries

# Acceptance Criteria:
# [x] If the title is the same as a show that I've already added, the details are not saved to the csv
# [x] If the title is the same as a show that I've already added, I will be shown an error that says "That show already exists!".

feature "user views list of TV shows" do
  scenario "view list of TV shows" do
    #Add data to your CSV that your test depends on
    visit "/new"

    fill_in "Show Title:", with: "Friends"
    fill_in "Network", with: "NBC"
    fill_in "Start Year:", with: "1994"
    fill_in "Synopsis", with: "Six friends living in New York city."
    select "Comedy", from: "Genre"

    click_button "Submit"

    visit "/new"

    fill_in "Show Title:", with: "Friends"
    fill_in "Network", with: "NBC"
    fill_in "Start Year:", with: "1994"
    fill_in "Synopsis", with: "Six friends living in New York city."
    select "Comedy", from: "Genre"

    click_button "Submit"

    expect(page).to have_content("That show already exists!")
  end
end
