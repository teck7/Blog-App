require "rails_helper"

RSpec.feature "Editing an article" do
  # User to create article first
  @article = Article.create(title: "Thie first article", body: "Lorem ipsum dolar sit amet, consectetur.")

  # User update an article
  scenario "A user updates an article" do
    visit "/"

    # Links to article title
    click_link @article.title

    # Links to edit article
    click_link "Edit Article"

    # Modified Contents
    fill_in "Title", with "Updated Title"
    fill_in "Body", with "Updated Body"

    # Update Article action
    click_button "Update Article"

    expect(page).to have_content("Article has been updated")
    expect(page.cuurent_path).to eq(article_path(@article))
  end


  scenario "A user fails to update an article" do
    visit "/"

    # Links to article title
    click_link @article.title

    # Links to edit article
    click_link "Edit Article"

    # Modified Contents
    fill_in "Title", with ""
    fill_in "Body", with ""

    # Update Article action
    click_button "Update Article"

    expect(page).to have_content("Article has not been updated")
    expect(page.cuurent_path).to eq(article_path(@article))
  end
end
