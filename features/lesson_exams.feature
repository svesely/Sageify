Feature: Assigning exams to a lesson
  In order match exams and lessons
  As a manager (or instructional designer)
  I want to assign exams to lessons
  
  Scenario: Going to the exam assignment screen
    Given I am logged in as an instructional designer
    And Unassigned Lesson 1 exists
    When I go to the lessons page
    And I follow "Unassigned Lesson 1"
    Then I should see "Assign exams"
  
  Scenario: Viewing existing exams
    Given I am logged in as an instructional designer
    And Unassigned Lesson 1 has an exam
    And an exam with questions
    And I go to the lessons page
    And I follow "Unassigned Lesson 1"
    And I follow "Assign exams"
    Then I should see "This old exam"
  
    When I follow "Attach another exam to this lesson"
    And I select "Big exam" from "assignment_exam_id"
    And I press "Submit"
    Then I should see "This old exam"
    And I should see "Big exam"
    
  Scenario: Viewing existing exams
    Given I am logged in as an instructional designer
    And Unassigned Lesson 1 has an exam
    And an exam with questions
    And I go to the lessons page
    And I follow "Unassigned Lesson 1"
    And I follow "Assign exams"
    Then I should see "This old exam"
    When I press "Remove Exam from Lesson"
    Then I should see "Exam successfully unassigned"
    And I should not see "This old exam"
  
