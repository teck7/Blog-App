require "rails_helper"

RSpec.feature "Creating Articles" do
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

    # User expectating a message
    expect(page).to have_content("Article has been created")
    # User expecting to be directed to new path
    expect(page.current_path).to eq(articles_path)
  end
end
