Feature: Assigning users to a lesson
  In order to match learning to specific users
  As a manager (or instructional designer)
  I want to assign users to lessons
  
  Scenario: Going to the user assignment screen
    Given I am logged in as an instructional designer
    And Unassigned Lesson 1 exists
    When I go to the lessons page
    And I follow "Unassigned Lesson 1"
    Then I should see "Assign users"
  
  Scenario: Viewing existing assignments
    Given I am logged in as an instructional designer
    And a learner exists
    And Assigned Lesson 1 exists
    And I go to the lessons page
    And I follow "Assigned Lesson 1"
    And I follow "Assign users"
    Then I should see "John Dorian"
  
  Scenario: Assigning a new user
    Given I am a logged in ID with a lesson and assigned user ready
    And a manager exists
    And I follow "Assign users"
    Then I should see "John Dorian"
    When I follow "Assign another user"
    And I select "Bob Kelso (Manager)" from "assignment_user_id"
    And I press "Submit"
    Then I should see "Bob Kelso"
    And I should see "John Dorian"
    
  Scenario: Removing a user assignment
    Given I am a logged in ID with a lesson and assigned user ready
    When I follow "Assign users"
    Then I should see "John Dorian"
    When I press "Delete assignment"
    Then I should see "User successfully unassigned"
    And I should not see "John Dorian"
  
  
  
  
  
