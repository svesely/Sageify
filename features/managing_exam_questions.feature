Feature: Managing Exam Questions
  In order to test the information learned
  As an instructional designer
  I want to view create and edit questions on an exam
  
  Background:
    Given I am logged in as an instructional designer
    And an exam with questions
    
  Scenario: No questions associated
    Given an old exam
    When I go to the exams page
    And I follow "This old exam"
    Then I should see "no questions"
  
  Scenario: Seeing the three questions
    When I go to the exams page
    And I follow "Big exam"
    Then I should see "Question 1"
    And I should see "Question 3"
    
  Scenario: Seeing some answers
    When I go to the exams page
    And I follow "Big exam"
    Then I should see "c. Another answer"
    And I should see "b. (Correct) Correct answer"
  
  
  
  
  
  
  

  
