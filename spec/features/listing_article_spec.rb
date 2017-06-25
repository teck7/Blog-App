require "rails_helper"

RSpec.feature "Creating Articles" do
  # Before listing articles
  before do
    # User to create article first
    @article1 = Article.create(title: "Thie first article", body: "Lorem ipsum dolar sit amet, consectetur.")
    @article2 = Article.create(title: "Thie second article", body: "Lorem ipsum dolar sit amet, consectetur.")
  end

  # User list the article
  scenario "A user lists all articles" do
    # Navigate to root page
    visit "/"

    # User expecting article content with title & body
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)

    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)

    # User expecting the actual article link by title
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end

  # User has no article
  scenario "A user has no article" do
    # Purge all existing article
    Article.delete_all
    # Navigate to root page
    visit "/"

    # User expecting no article content with title & body
    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)

    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)

    # User expecting no actual article link by title
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    # Display no article created
    within ("h1#no_articles") do
      expect(page.to have_content("No Articles Created")
    end
  end
end
