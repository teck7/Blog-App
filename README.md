# Blog Application (Ruby on Rails)

## Project Scope
This is a Blog application using the RSpec TDD and Capybara BDD because there are popular and widely used in the industry. This application allow us to create blog post and post in online using Rails 5 framework.

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
- expect some message when there are no articles been added

Inside the articles/index.html.erb file, add in <% @ articles.each do |article| %> to go list through all created article. However, you would still get the following list of failures.

Failure 1: ActionView::Template::Error:
           undefined method "each"

Solution 1: Add @ articles = Article.all into index
            action in articles_controller.rb
            (i.e to list all articles in index page)

Failure 2: Failure/Error: expect(page).to
           have_link(@ article1.title)
           expected to find link "Thie first article"

Solution 2: Add <%= link_to article.title,
            article_path(article) %> into articles/index.html.erb file
            (i.e add in a link to show the actual created article path)

Failure 3: Capybara::ElementNotFound:
           Unable to find css "h1#no_articles"

Solution 3: Add in contents <h1 id="no-aritcles">No
            Articles Created</h1> and ifelse statement to show the message to user as required. This will be done in  index.html.erb

##### Show Article Feature Test
In feature folder, create a file "show_article_spec.rb". Inside the file write out all neccessary codes before running rspec in CLI. Then, solve any failure step by step.

- create 1 article to display
- show the article title and details

Of course, you will get the following failures.

Failure 1: AbstractController::ActionNotFound:
           The action 'show' could not be found

Solution 1: Add in def show end into
            articles_controller.rb file and add in @ article = Article.find(params[:id])
            (i.e define show action and find article by its id)

Failure 2: Show action template is missing

Solution 2: Implement show.html.erb under views/articles
            directory

##### Request Article Error Feature Test
In spec folder, create a request folder and inside create articles_spec.rb file. Inside the file write out all neccessary codes before running rspec in CLI. Then, solve any failure step by step.

- write some web responses if no article found

Failure 1: ActiveRecord::RecordNotFound:
           Couldn't find Article with 'id'=xxxx

Solution 1: it in the application controller by adding
            the code below:

            rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

            protected

            def resource_not_found
            end

             In articles controller:

             protected
              def resource_not_found
              message = "The article you are looking for could not be found"
              flash[:alert] = message
              redirect_to root_path
              end

##### Show Article Feature Test
In feature folder, create a file "edit_article_spec.rb". Inside the file write out all neccessary codes before running rspec in CLI. Then, solve any failure step by step.

- show the article title and details
- update article contents (title and body)
- what if article is not updated correctly

Of course, you will get the following failures.

Failure 1: Unable to find link "Edit Article"

Solution 1: In show.html.erb file,add the link:
            <%= link_to "Edit Article", edit_article_path(@ article), class: "btn btn-primary btn-lg btn-space" %>

Failure 2: The action 'edit' could not be for ArticlesController

Solution 2: Add the edit action and inside the edit action add in @ article = Article.find(params[:id])

Failure 3: ActionController::UnknownFormat:
           ArticlesController#edit is missing a template for this request

Failure 4: AbstractController::ActionNotFound:
            The action 'update' could not be found for ArticlesController

Solution 4: Create the update action in
            articles_controller.rb file:
            Inside the update action add in

            @ article = Article.find(params[:id])

            if @ article.update(article_params)
              flash[:success] = "Article has been updated"
              redirect_to @ article
            else
              flash.now[:danger] = "Article has not been updated"
              render :edit
            end
            end

##### Delete Article Feature Test
In feature folder, create a file "delete_article_spec.rb". Inside the file write out all neccessary codes before running rspec in CLI. Then, solve any failure step by step.

- show the article title and details
- delete article contents (title and body)
- what if article is not deleted correctly

Of course, you will get the following failures.

Failure 1: Unable to find link "Delete Article"

Solution 1: In app/views/articles/show.html.erb, add in <%= link_to "Delete Article", article_path(@ article),
method: :delete,
data: { confirm: "Are you sure you want to delete article?" },
class: "btn btn-primary btn-lg btn-space" %>

Failure 2: Action 'destroy' could not be found for ArticlesController

Solution 2: Add the destroy action in articles controller as followed

  def destroy
    @ article = Article.find(params[:id])
  if @ article.destroy
    flash[:success] = "Article has been deleted."
    redirect_to articles_path
    end
  end

## REFACTOR THE EXISTING CODE
- refactor the article controller using filters
  (i.e insert @ article = Article.find(params[:id]) into set_article method within private)

- create a partial file, "form.html.erb" in
  app/views/articles directory
  (i.e cut all the common code from new.html.erb and edit.html.erb except the heading and paste into form.html.erb )

## Adding Devise Gem for User Management
- Visit Devise Github repo for installation and setup
  information

### User Signup Setup Feature Test
In feature folder, create a file "signing_up_users_spec.rb". Inside the file write out all neccessary codes before running rspec in CLI. Then, solve any failure step by step.

- vist root first
- click on sign-up link
- email
- password
- password confirmation
- sign-up
- invalid Signup
- do an invalid sign-up and ensure that it fails

Of course, you will get the following failures.

Failure 1: Unable to find link 'Sign up'

Solution 1: Add <li><%= link_to "Sign up",
            new_user_registration_path %></li> into application.html.erb
            (i.e after <li class="active"><%= link_to "Authors", "#" %></li>)

            Add <li><%= link_to "Sign out", destroy_user_session_path, method: :delete %></li>
            into application.html.erb
            (i.e after <li class="active"><%= link_to "Authors", "#" %></li>)

### User Signin Setup Feature Test
In feature folder, create a file "signing_users_in_spec.rb". Inside the file write out all neccessary codes before running rspec in CLI. Then, solve any failure step by step.

- vist root first
- click on sign-inp link
- email
- password
- sign-in
- sign-up
- invalid Sign-in
- invalid Sign-up
- do an invalid sign-in and ensure that it fails
- do an invalid sign-up and ensure that it fails

Of course, you will get the following failures.

Failure 1: Unable to find link 'Sign in'

Solution 1: Add <li><%= link_to "Sign in",
            new_user_session_path %></li> into application.html.erb

Failure 2: Expected to find signed in as!!!!

Solution 2: Add the following code below sign-in:

            <% if user_signed_in? %>
              Signed in as <%= "#{current_user.email}" %>
            <% end %>

Failure 3: Failure/Error: expect(page).not_to have_link("Sign
           in") expected not to find link "Sign in"

Solution 3: Modify the links to look like (just under the
            Author link in application.html.erb)

            <% unless user_signed_in? %>
              <li><%= link_to "Sign up", new_user_registration_path %></li>
              <li><%= link_to "Sign in", new_user_session_path %></li>
            <% end %>

            (i.e Get rid of              
              <li><%= link_to "Sign up", new_user_registration_path %></li>
              <li><%= link_to "Sign out", destroy_user_session_path, method: :delete %></li>
              <li><%= link_to "Sign in", new_user_session_path %></li>
              )

## REFACTOR LATEST CODE
- factor the layout file into partials
  (i.e create a folder within views called shared. In the shared folder create a file called header.html.erb and cut the header portion from the layout file (application.html.erb) and paste it into this file)
