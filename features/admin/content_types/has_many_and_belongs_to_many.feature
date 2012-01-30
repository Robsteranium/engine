Feature: Create and manage has many-to-many relationships
  In order to work with two associated models together
  As an administrator
  I want to set up and manage a has many-to-many relationship

Background:
  Given I have the site: "test site" set up
  And I have a custom model named "Projects" with
    | label       | kind      | required    | target  |
    | Name        | string    | true        |         |
    | Description | text      | false       |         |
  And I have a custom model named "Clients" with
    | label       | kind      | required    | target   |
    | Name        | string    | true        |          |
    | Description | string    | false       |          |
    | Projects    | has_many  | false       | Projects |
  And I add the following to a custom model named "Projects"
    | label       | kind      | required    | target   |
    | Clients     | has_many  | false       | Clients  |
  And I have entries for "Clients" with
    | name              | description                |
    | Alpha, Inc        | Description for Alpha, Inc |
    | Beta, Inc         | Description for Beta, Inc  |
    | Gamma, Inc        | Description for Gamma, Inc |
  And I have entries for "Projects" with
    | name              | description                    |
    | Fun project       | Description for the fun one    |
    | Boring project    | Description for the boring one |

  And I am an authenticated user

@javascript
Scenario: I add a client to a project
  When I go to the "Clients" model list page
  And I follow "Alpha, Inc"
  And I wait until the has many selector is visible
  Then I should see "Empty" within the list of items
  Then "Fun project" should be an option for "label"
  And I press "+ add"
  When I press "Save"
  And I wait until the has many selector is visible
  Then I should see "Fun project" within the list of added items
  And "Fun project" should not be an option for "label"
  When I go to the "Projects" model list page
  And I follow "Fun project"
  And I wait until the has many selector is visible
  Then I should see "Fun project" within the list of added items
  Then I should not see "Empty" within the list of items
  
