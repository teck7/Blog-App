require "rails_helper"

RSpec.feature "Deleting an Article" do

  # User to create article first
  before do
    john = User.create(email: "john@example.com", password: "password")
    login_as(john)
    @article = Article.create(title: "Title One", body: "Body of article one", user: john)
  end

  scenario "A user deletes an article" do

    # Navigate to root page
    visit "/"

    # Link on article's title
    click_link @article.title

    # Links to delete article
    click_link "Delete Article"

    # User not expecting article content with title & body
    expect(page).to have_content("Article has been deleted")

    # Ensure the article path is equal to the path that the article is created
    expect(current_path).to eq(articles_path)
  end

end
