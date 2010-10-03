Feature: Creating Web Based Training Lessons
  In order to train learners with a web based system
  As an instructional designer
  I want to be able to create multiple pages of linked markup to convey a subject

  Background:
    Given I am logged in as an instructional designer

  Scenario: Index lessons
    And a test lesson
    When I go to the lessons page
    Then I should see "Test Lesson 1"
    And I should not see "Test Lesson 2"
  
  Scenario: Creating lessons
    When I go to the lessons page
    And I follow "New"
    Then I should see "New lesson"
    
  Scenario: Creating a new lesson successfully
    When I go to the new lesson page
    And I fill in "name" with "Test Lesson 1"
    And I fill in "description" with "This is an example description"
    And I press "Create"
    Then I should see "Test Lesson 1"
    And I should see "This is an example description"

  Scenario: Creating a lesson unsuccessfully
    Given I go to the new lesson page
    When I go to the new lesson page
    And I fill in "description" with "This is an example description"
    And I press "Create"
    Then I should see "Name can't be blank"

  Scenario: Viewing lessons by title
    When I go to the new lesson page
    And I fill in "name" with "Test Lesson 1"
    And I fill in "description" with "This is an example description"
    And I press "Create"
    And I go to the lessons page
    Then I should see "Test Lesson 1"
    And I should see "0 pages"
  
  
  

  
  
  
  
  