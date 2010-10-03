Feature: Landing page
  In order to quickly get to information that I'm interested in
  As an admin
  I want to hit a straightforward landing page when I log in
  
  Scenario: No lessons in the system
    Given no lessons exist
    When I log in as a manager
    Then I should see "Getting Started . . ."
    And I should see "To get started"
  
  
  

  
