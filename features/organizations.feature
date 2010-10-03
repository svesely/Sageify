Feature: Organizations
  In order to add a new organization to the system or manipulate the users therein
  As a manager
  I want a way to create an org or add/delete users
  
  Scenario: New organization page
    Given I am not logged in
    When I go to the signup page
    Then I should see "Add your organization!"
  
  
  Scenario: Adding a new organization
    Given I am not logged in
    And I go to the signup page
    When I fill in "signup_presenter_organization_name" with "Vesopolis"
    And  I fill in "signup_presenter_user_first_name" with "Scott"
    And  I fill in "signup_presenter_user_last_name" with "Vesely"
    And  I fill in "signup_presenter_user_email" with "blah@example.com"
    And  I fill in "signup_presenter_user_password" with "password"
    And  I fill in "signup_presenter_user_password_confirmation" with "password"
    And  I press "Submit"
    Then I should see "Your organization has been added!"
    
  Scenario: Not enough info
    Given I am not logged in
    And I go to the signup page
    When I fill in "signup_presenter_organization_name" with "Vesopolis"
    And  I fill in "signup_presenter_user_password_confirmation" with "password"
    And  I press "Submit"
    Then I should not see "Your organization has been added!"
    And I should see "Email is too short"
    And I should see "Password is too short"
  
  Scenario: Viewing organization information
    Given I am logged in as a manager
    When I go to the organization page
    Then I should see "Organization: Orgrimmar"
    
  # Scenario: Learners should not see organization information
  #   Given I am logged in as a learner
  #   When I go the organizations page
  #   Then I should not see "Organization: Orgrimmar"
  #   And I should see "go away bitch"
  
  
  
  
  
  
  
  
  
  
  
  
  
  
