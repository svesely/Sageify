Feature: Logging in and out
  In order to authenticate users and tailor custom content
  As a Instructional Designer
  I want to log in and see the Lessons page

  Scenario: Not logged in
    Given I am not logged in
    When I go to the lessons page
    Then I should see "You need to sign in or sign up before continuing"
 
  Scenario: logged in as a learner accessing lessons
    Given I am logged in as a learner
    When I go to the lessons page
    Then I should see "Sorry, your role does not permit you access to this resource"
 
  Scenario: logged in as ID
    Given I am logged in as an instructional designer
    Then I should see "Lessons:"
  
  
  
  
