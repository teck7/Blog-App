require "rails_helper"

RSpec.feature "Creating Articles" do
  # Before listing articles
  before do
    @john = User.create(email: "john@example.com", password: "password")
    # User to create article first
    @article1 = Article.create(title: "The first article", body: "Lorem ipsum dolor sit amet, consectetur.", user: @john)
    @article2 = Article.create(title: "The second article", body: "Body of 2nd article", user: @john)
  end

  # User list the article and not signed in
  scenario "with articles created and user not signed in" do
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

    #Updated for retrict access
    expect(page).not_to have_link("New Article")
  end

  # User list the article and signed in
  scenario "with articles created and user signed in" do
    #Signed in as john
    login_as(@john)

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

    #Updated for retrict access
    expect(page).not_to have_link("New Article")
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

    #Updated for retrict access
    expect(page).to have_link("New Article")

    # Display no article created
    within ("h1#no-articles") do
     expect(page).to have_content("No Articles Created")
    end

  end

end
