# Blog Application (Ruby on Rails)

## Project Scope
This is a Blog application using the RSpec TDD and Capybara BDD because there are popular and widely used in the industry.

## Testing Scope
### Unit Tests
- models, views, routes etc
- each individual component is tested one item at a time
- typically results in very good coverage

### Functional Tests
- controllers
- testing multiple components and how they collaborate with each other
- multiple models in a process

### Integration Tests
- involves business processes to meet application objective
- emulate a user such as logging in and clicking on a submit blog button

### RSpec and Capybara
- Add gem 'rspec-rails', '~> 3.4', '>= 3.4.2' into
  development
- Add gem 'capybara', '~> 2.7', '>= 2.7.1' into test
- write out the scenario in a test file

#### First Step
- Build the features one by one until the test passes

##### Process & Strategy
- Create a branch to do the development work
- Write feature test
- Build feature to make test pass one by one
- Once the feature test passes with no errors - merge with master branch

##### Creating New Article
- Visit root page
- click on new article
- fill in tile
- fill in the body
- create article
- (Expectation 1) if successful: article has been created message shown
- (Expectation 2) then direct the articles path

For the above, need to create a features folder in spec folder. In feature folder, create a file "creating_article_spec.rb". Inside the file write out all neccessary codes before running rspec in CLI. Then, solve any failure step by step.

However, to test only the above feature, just type in rspec spec/features/creating_article_spec.rb

1st Failure: ActionController::RoutingError:
             No route matches [GET] "/"

Solution 1: Create route in config/routes.rb
            (i.e root to: "articles#index")

2nd Failure: ActionController::RoutingError:
             uninitialized constant ArticlesController

Solution 2: Run "rails g controller articles index"
            (i.e generate a controller for article with a index action). Remove   get 'articles/index' from routes.rb

3rd Failure: This failure is detected by Capybara
             Unable to find link "New Article"

Solution 3: Add in "<%= link_to "New Article",
            new_article_path %>" into views/articles/index.html.erb file
            (i.e create a link that links navigate to new article path)

4th Failure: ActionView::Template::Error:
             undefined local variable or method new_article_path

Solution 4: Add in "resources :articles" into routes.rb file
            (i.e implement all routes for articles)

5th Failure: AbstractController::ActionNotFound:
             The action 'new' could not be found for ArticlesController      

Solutin 5: Add in "def new end" into articles_controller.rb
           (i.e add new action into article controller)

6th Failure: ActionController::UnknownFormat:
             ArticlesController#new is missing a template for this request format and variant.

Solution 6: Develope a new.html.erb file in views/articles
            directory

7th Failure: Capybara::ElementNotFound:
             Unable to find field "Title" & find field "body" & find "submit button" for posting new article

Solution 7: Create form template inside on new.html.erb file
            (i.e add input form fields and button)

8th Failure: ActionView::Template::Error:
             First argument in form cannot contain nil or be empty. (i.e The first argument @ article)

Solution 8: Add in @ artilce = Article.new into new action inside of articles_controller.rb file

9th Failure: NameError:
            uninitialized constant ArticlesController::Article
            (i.e missing model for Article)

Solution 9: Run "rails g model article title:string
            body:text"
            (i.e generate a model for article that has title as string and body as text). This will generate  a schema at the same time.

10th Failure: Occurs only if forget to run "rails
              db:migrate"

11th Failure: AbstractController::ActionNotFound:
              The action 'create' could not be found for ArticlesController

Solution 11: Add in "def create end" into
             articles_controller.rb file.

12th Failure: Capybara::ElementNotFound:
              Unable to find xpath "/html"
              (i.e no article flash success message after created article)

Solution 12: Add in required codes into create action
             (i.e @ article = Article.new(article_params) / @ article.save / flash[:success] / redirect_to articles_path )

13th Failure: NameError:
              undefined local variable or method "article_params"

Solution 13: Add in private method for article_params into
             the same file

14th Failure: Failure/Error: expect(page).to
              have_content("Article has been created")
              expected to find text "Article has been created" in "Articles#index
              (i.e have to display the flash message in the html layout/application.html)

Solution 14: Add in some flash message codes into the body
             tag (i.e flash.each do |key, message|) for each blog post

Finally, we get 1 example, 0 failures after all test been passed. Now go to localhost:3000/articles and click create new article. This will direct user to localhost:3000/articles/new page. After filling up the form, new article message will flash success once directed back to localhost:3000/articles.

##### Add Automating Testing using following Gems
Insert the Gems into development section in Gemfile
- gem 'guard', '~>2.14.0'
- gem 'guard-rspec', '~> 4.7.2'
- gem 'guard-cucumber', '~> 2.1.2'

If run "guard" on CLI, the testing framework keeps running in the background, and do no t need to run rspec on CLI regularly. To let this happen, needs to change the Guardfile contents. The testing would be run automatically in the background just to check if anything is broken dynamically.

The above Guard gem is used to test the following scenario
- Write a second scenario to test what if the user has not fill out the form properly before submitting the article post.
- The Guard file will automatically state the failure/errors so developers could make adjustment as neccessary.

In order to pass/solge above failures/errors,
- need to integrate ifelse statement in the create action in articles_controller.rb file to show the right flash message if user properly fill in the form inputs.
- need to add form display error messages into new.html.erb file.

##### Listing Articles Feature Test
In feature folder, create a file "listing_article_spec.rb". Inside the file write out all neccessary codes before running rspec in CLI. Then, solve any failure step by step.

- create a number of articles
- list the number of articles
- expect both article titles and bodies to be present

Inside the articles/index.html.erb file, add in <% @ articles.each do |article| %> to go list through all created article. However, you would still get the following list of failures.

Failure 1: ActionView::Template::Error:
           undefined method "each"

Solution 1: Add @ articles = Article.all into index
            action in articles_controller.rb
            (i.e to list all articles in index page)

Failure 2: Failure/Error: expect(page).to
           have_link(@article1.title)
           expected to find link "Thie first article"

Solution 2: Add <%= link_to article.title,
            article_path(article) %> into articles/index.html.erb file
            (i.e add in a link to show the actual created article path)
