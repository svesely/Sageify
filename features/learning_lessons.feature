Feature: Learning Lessons
  In order to learn a new skill or process
  As a Learner
  I want to view the entirety of a lesson that's available to me
  
  Scenario: Viewing Learner Lesson 1
    Given I am logged in as a learner
    And Assigned Lesson 1 has three pages
    When I go to the learn page
    And I follow "Assigned Lesson 1"
    Then I should see "You are viewing Assigned Page 1!"

  Scenario: Moving to page 2
    Given I am logged in as a learner
    And Assigned Lesson 1 has three pages
    When I go to the learn page
    And I follow "Assigned Lesson 1"
    And I follow "Next"
    Then I should see "You are viewing Assigned Page 2!"
  
  Scenario: Learner Lesson 1 Completed
    Given I am logged in as a learner
    When I am done viewing Assigned Lesson 1
    And I go to the learn page
    Then I should see "Assigned Lesson 1 (Completed)"
    
  Scenario: Viewing Learner Lesson 1
    Given I am logged in as a learner
    And Assigned Lesson 1 has three pages
    And Assigned Lesson 1 has an exam
    When I go to the learn page
    And I follow "Assigned Lesson 1"
    Then I should see "You are viewing Assigned Page 1!"
    And I should not see "Take This old exam"
  
  Scenario: Receiving exams should happen after I'm done viewing the lesson
    Given I am logged in as a learner
    And Assigned Lesson 1 has an exam
    And I am done viewing Assigned Lesson 1
    Then I should see "Take This old exam" 
  
  
  
  

  
