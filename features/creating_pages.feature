Feature: Creating Pages in a Lesson
  In order to create discreet sections of information in an overall lesson
  As an Instructional Designer
  I want To create pages that represent the path a learner will taken in my lesson
  
  Background:
    Given I am logged in as an instructional designer
  
  Scenario: Adding initial page content
    Given I have created a lesson
    And I follow "Add a new page"
    When I fill in "content" with "h1. This is my first page!"
    And I fill in "title" with "My best page"
    And I press "Save and preview this page"
    Then I should see "This is my first page!"
    
  Scenario: Unsuccessfully attempting to add a page
    Given I have created a lesson
    And I follow "Add a new page"
    When I fill in "content" with "h1. This is my first page!"
    And I press "Save and preview this page"
    Then I should see "Title can't be blank"
  
    
  Scenario: Exiting to lesson
    Given I have created a lesson
    And I follow "Add a new page"
    And I fill in "title" with "Another great page"
    And I fill in "content" with "h1. This is my first page!"
    When I press "Save and exit to lesson" 
    Then I should see "Page was successfully created"
    And I should see "Lesson: "

  Scenario: Creating an additional page
    Given I have created a lesson
    And I follow "Add a new page"
    And I fill in "title" with "Another great page"
    And I fill in "content" with "h1. This is my first page!"
    When I press "Save and add another page"
    Then I should not see "h1. This is my first page!"
    And I should not see "There was an error"
    And I should see "New page"
  
  
  
  
  

  
