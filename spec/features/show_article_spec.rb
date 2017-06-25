require "rails_helper"

RSpec.feature "Showing an article" do

  before do
    # User to create article first
    @article = Article.create(title: "Thie first article", body: "Lorem ipsum dolar sit amet, consectetur.")
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
