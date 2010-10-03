Feature: Editing Pages in a Lesson
  In order ensure that page content is correct and up-to-date
  As an Instructional Designer
  I want To edit existing pages and save their new content
  
  Background:
    Given I am logged in as an instructional designer
    
  Scenario: Editing page 2 of 3
    Given I have created a lesson with a few pages
    And I navigate to the page 2 edit
    And I fill in "title" with "New Title"
    And I press "Save and exit to lesson"
    Then I should see "New Title"
    And I should not see "Test Page 2"
 
  Scenario: Cancelling out of an edit
    Given I have created a lesson with a few pages
    And I navigate to the page 2 edit
    And I fill in "title" with "New Title"
    And I press "Cancel"
    Then I should not see "New Title"
    And I should see "Test Page 2" 
  
  
  