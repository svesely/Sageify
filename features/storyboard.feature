Feature: Storyboard
  In order to see the big picture 
  As a instructional designer
  I want to see a storyboard of my lesson all at once
  
  Scenario: Should see all pages
    Given I am logged in as an instructional designer
    And a learner exists
    And Assigned Lesson 1 has three pages
    When I go to the lessons page 
    And I follow "Assigned Lesson 1"
    And I follow "See storyboard"
    Then I should see "You are viewing Assigned Page 1!"
    Then I should see "You are viewing Assigned Page 2!"
    Then I should see "You are viewing Assigned Page 3!"
  
  
