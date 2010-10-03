Feature: Viewing scores
  In order to see how my associates are doing on tests
  As a manager
  I want to view their scores
  
  Background:
    Given I am logged in as a manager
    
  Scenario: Viewing score overview
    Given a learner exists
    And a learner has taken an exam
    When I go to the scores page
    Then I should see "learner"
    And I should see "66.67%"
    And I should see "(Fail)"
  
  Scenario: Viewing score detail
    Given a learner exists
    And a learner has taken an exam
    When I go to the scores page
    And I follow "66.67% on Big exam"
    Then I should see "details"
    And I should see "Big exam"
    And I should see "John Dorian"
    And I should see "66.67%" 
    And I should see "Fail"
    And I should see "a. (Selected) An answer"
    And I should see "b. (Correct) Correct answer"
    And I should see "b. (Correct, Selected) Correct answer"
    