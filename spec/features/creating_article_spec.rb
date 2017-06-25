require "rails_helper"

RSpec.feature "Creating Articles" do
  # First Scenario Test Case
  scenario "A user creates a new article" do
    # Navigate to root page
    visit "/"

    # Click on a link to create new article
    click_link "New Article"

    # Fill in information req' for blog
    fill_in "Title", with: "Creating a blog"
    fill_in "Body", with: "Lorem Ipsum"

    # Click button to create article
    click_button "Create Article"

    # User expecting a message
    expect(page).to have_content("Article has been created")
    # User expecting to be directed to new path
    expect(page.current_path).to eq(articles_path)
  end

  # Second Scenario Test Case
  scenario "A user fails to create a new article" do
    visit "/"

    click_link "New Article"

    # Nothing is filled in by the user
    fill_in "Title", with: ""
    fill_in "Body", with: ""

    click_button "Create Article"

    # User expecting a message
    expect(page).to have_content("Article has not been created")
    # User expecting a message from form fill out result
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end

end
