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
- write out the scenario in a test file

#### First Step
- Build the features one by one until the test passes

##### Process & Strategy
- Create a branch to do the development work
- Write feature test
- Build feature to make test pass one by one
- Once the feature test passes with no errors - merge with master branch
