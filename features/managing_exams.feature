Feature: Managing Exams
  In order to test the knowledge gained by the learner
  As a Instructional Designer
  I want to create and edit exams
  
  Background: 
    Given I am logged in as an instructional designer
    Given three exams exist
    
  
  Scenario: Indexing exams
    When I go to the exams page
    Then I should see "Exams:"
    And I should see "Exam 1"
    And I should see "Exam 2"
    And I should see "Exam 3"
  
  Scenario: Getting to the new exam page
    When I go to the exams page
    And I follow "New exam"
    Then I should see "New exam"
    And I should see "Name"
  
  Scenario: Adding a new exam
    When I go to the new exam page
    And I fill in "name" with "New exam name"
    And I press "Save and exit to exams index"
    Then I should see "Exams:"
    And I should see "New exam name"
  
  Scenario: Editing an old exam
    Given an old exam
    When I go to the exams page
    And I follow "This old exam"
    And I follow "edit"
    And I fill in "name" with "New hotness"
    And I press "Save and exit to exams index"
    Then I should see "Exams:"
    And I should see "New hotness"
    And I should not see "This old exam"
  
  
  
  
  
  
  
