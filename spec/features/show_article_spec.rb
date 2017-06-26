require "rails_helper"

RSpec.feature "Showing an article" do

  before do
    john = User.create(email: "john@example.com", password: "password")
    login_as(john)
    # User to create article first
    @article = Article.create(title: "Title One", body: "Body of article one", user: john)
  end

  scenario "A user shows an article" do
    # Navigate to root page
    visit "/"

    # Link on article's title
    click_link @article.title

    # User expecting article content with title & body
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)

    # Ensure the article path is equal to the path that the article is created
    expect(current_path).to eq(article_path(@article))
  end
end
