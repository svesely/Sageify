Feature: User management
  In order to add and edit user records
  As a manager
  I want to see and edit the users in my organization

  Scenario: Adding an additional user
    Given I am logged in as a manager
    When I go to the new user page
    And I fill in "user_first_name" with "John"
    And I fill in "user_last_name" with "Dorian"
    And I fill in "user_email" with "vanilla_bear@example.com"
    And I press "Submit"
    Then I should see "User Created!"
    And I should see "vanilla_bear@example.com"
    And I should see "John Dorian: Learner"
  
  Scenario: Granting permissions available as a manager
    Given I am logged in as a manager
    When I go to the new user page
    Then I should see "Manager?"
    
  Scenario: No grant permissions when an ID
    Given I am logged in as an instructional designer
    When I go to the new user page
    Then I should see "First name"
    And I should not see "Manager?"
  
  Scenario: Granting permissions as a manager
    Given I am logged in as a manager
    When I go to the new user page
    And I fill in "user_first_name" with "John"
    And I fill in "user_last_name" with "Dorian"
    And I fill in "user_email" with "vanilla_bear@example.com"
    And I check "instructional_designer"
    And I press "Submit"
    Then I should see "John Dorian: Instructional Designer"

  Scenario: Regular Users Should be editable to instructional designers, but not managers
    Given I am logged in as an instructional designer
    And a manager exists
    And a learner exists
    When I go to the users page
    Then I should see "learner@example.com (Edit)"
    And I should not see "manager@example.com (Edit)"
  
