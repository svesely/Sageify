Feature: Assessments
  In order to demonstrate the value of the material learned
  As a learner
  I want to take an assessment and see my score
  
  Background:
    Given I am logged in as a learner
    And I have been assigned a lesson with an exam
  
  Scenario: Available exams
    When I go to the assessments page
    Then I should see "Available assessment"
  
  Scenario: Viewing questions
    Given I go to the assessments page
    When I follow "Available assessment"
    Then I should see "Question, the first"
    And I should see "Choice, the first"
  
  Scenario: Viewing questions
    Given I go to the assessments page
    And I follow "Available assessment"
    And I choose "questions_1_a"
    And I press "Submit"
    And I should see "Assessment successfully completed" 