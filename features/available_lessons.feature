Feature: Viewing lessons
  In order to learn a new skill or policy
  As a learner
  I want to sign in and view a lesson
  
  Scenario: No Assigned Lessons
    Given I am logged in as a learner
    And Unassigned Lesson 1 exists
    When I go to the learn page
    Then I should see "Unassigned Lesson 1"
    And I should not see "(Assigned)"
  
  Scenario: Assigned Lessons
    Given I am logged in as a learner
    And Assigned Lesson 1 has three pages
    And Unassigned Lesson 1 exists
    When I go to the learn page
    Then I should see "Assigned Lesson 1 (Assigned)"
    And I should see "Assigned Lesson 1"
    And I should not see "Unassigned Lesson 1 (Assigned)"
    
    #TODO
    # Scenario: Invisible Lessons
    #   Given I am logged in as a learner
    #   And Learner Lesson 1
    #   When I sign in
    #   Then I should not see "Manager Lesson 1"
    #   And I should see "Learner Lesson 1"
    # 

    
  
  
  
  
