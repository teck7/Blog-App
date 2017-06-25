require "rails_helper"

RSpec.feature "Deleting an Article" do

  # User to create article first
  before do
    @article = Article.create(title: "The first article", body: "Lorem ipsum dolor sit amet, consectetur.")
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
