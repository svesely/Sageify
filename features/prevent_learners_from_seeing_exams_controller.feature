Feature: Prevent learners from seeing exams controller
  In order to stop learners from messing with the exams
  As an instructional designer
  I want to prevent learners from accessing the /exams url
  
  Scenario: Do not permit unless instructional designer
    Given three exams exist
    And I am logged in as a learner
    When I go to the exams page
    Then I should not see "Exams 1"
    And I should see "your role does not permit"

  
