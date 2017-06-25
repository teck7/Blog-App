class Article < ApplicationRecord
  # Ensure the title and body of article is present in input field
  validates :title, presence: true
  validates :body, presence: true

  # Make sure the latest post is at the top of the page
  default_scope { order(created_at: :desc) }
end
