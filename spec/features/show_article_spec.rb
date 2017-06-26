require "rails_helper"

RSpec.feature "Showing an article" do

  before do
    @john = User.create(email: "john@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")

    # User to create article first
    @article = Article.create(title: "Title One", body: "Body of article one", user: @john)
  end

  scenario "to non-signed in user hide the Edit and Delete buttons" do
    # Navigate to root page
    visit "/"

    # Link on article's title
    click_link @article.title

    # User expecting article content with title & body
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)

    # Ensure the article path is equal to the path that the article is created
    expect(current_path).to eq(article_path(@article))

    # Ensure page not to have edit / delete links if not signed in
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "to non-owner hide the Edit and Delete buttons" do
    # login as different owner rather than john
    login_as(@fred)

    # Navigate to root page
    visit "/"

    # Link on article's title
    click_link @article.title

    # User expecting article content with title & body
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)

    # Ensure the article path is equal to the path that the article is created
    expect(current_path).to eq(article_path(@article))

    # Ensure page not to have edit / delete links if not signed in
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
end
