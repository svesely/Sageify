Feature: Creating questions
  In order to test the knowledge of learners
  As an instructional designer
  I want to add new questions to an exam

  Background:
    Given I am logged in as an instructional designer
    And an exam with questions
    And I go to the exams page
    And I follow "Big exam"
    
  Scenario: Visiting the new question page
    When I follow "Add a question"
    Then I should see "New question"
    And I should see "Text"
    And I should see "a."
    And I should see "b."
    And I should see "c."
    And I should see "d."
    And I should see "e."
  
  Scenario: Creating a new valid question
    Given I follow "Add a question"
    When I fill in "question_text" with "This is a new question"
    And I choose "question_correct_choice_letter_b"
    And I fill in "question_choices_attributes_0_text" with "Incorrect answer"
    And I fill in "question_choices_attributes_1_text" with "Correct Answer"
    And I fill in "question_choices_attributes_2_text" with "Another incorrect answer"
    And I press "save_and_done"
    Then I should see "Question was successfully created"
    And I should see "This is a new question"
    And I should see "(Correct) Correct Answer"
    
  Scenario: I have to correct a problem on entry of a question
    Given I follow "Add a question"
    When I fill in "question_text" with ""
    And I press "save_and_done"
    Then I should see "Text can't be blank"
    And I should see "a."
    And I should see "b."
    And I should see "c."
    And I should see "d."
    And I should see "e."
  
  Scenario: I forget to choose a correct answer
    Given I follow "Add a question"
    When I fill in "question_text" with ""
    And I press "save_and_done"
    Then I should see "You must select a correct choice"
  
  Scenario: Choosing an option that isn't filled in
    Given I follow "Add a question"
    When I fill in "question_text" with "This is a new question"
    And I choose "question_correct_choice_letter_d"
    And I fill in "question_choices_attributes_0_text" with "Incorrect answer"
    And I fill in "question_choices_attributes_1_text" with "Correct Answer"
    And I fill in "question_choices_attributes_2_text" with "Another incorrect answer"
    And I press "save_and_done"
    Then I should see "You must select a correct choice"  
  