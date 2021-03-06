Feature: Admin Features
  
  As an admin
  I want to see a list of users
  So that I can manage them
  I want to see a list of all questions
  So that I can manage them or create new category
  I want to see scales 
  So that I can manage them or create new scale
  I want to see a list of all scenarios
  So that I can manage them or create new scenario
  
Background:  Log in as an Admin
  Given I log in as an Admin
  Then I should see "Welcome to the TAMURAT"
  
  Scenario: Admin can see all users list
    Given I am on All user page
    Then I should see "All users"
    Then I should see "pickle-rick"
    Then I should see "pickle-morty"
    # Search
    Given I search user "pickle-rick"
    Then I should see "pickle-rick"
    Then I should not see "pickle-morty"
    Then I should not see "Example DM1"
    Given I press "Refresh"
    Then I should see "pickle-rick"
    Then I should see "pickle-morty"
    Then I should see "Example DM1"
    # Filter
    When I uncheck the following role: Administrator, Validator
    When I press "Refresh"
    Then I should not see "Example Admin"
    Then I should not see "Example VA1"
    Then I should see "Example DM1"
    Then I should see "Example CR1"

  # Scenario: Admin can delete user
  #   Given I am on All user page
  #   When I delete the first user
  #   Then I should see "User deleted"
  #   Then I should not see "Example DM1"
    
  Scenario: Activate a user
    Given I am on All user page
    When I activate a user
    Then I should see "Successfully send email"
  
  Scenario: Admin can management all questions
    Given I am on All question page
    Then I should see "All Question"
    # Category create/edit
    Given I edit the first category into "pickle-rick"
    Then I should see "pickle-rick was successfully updated."
    Given I create a new category "pickle-morty"
    Then I should see "pickle-morty was successfully created."
    # Subcategory create/edit
    Given I click link "pickle-rick"
    Then I should see "Business_1"
    Given I edit subcategory "Business_1" into "pickle-rick_1"
    Then I should see "pickle-rick_1 was successfully updated."
    Then I should see "Weight_sum = 9.7"
    #Given I click link "pickle-rick Weight = 0.0"
    Then I should see "pickle-rick_1"
    Given I create a new subcategory "pickle-rick_4"
    Then I should see "pickle-rick_4 was successfully created."
    #Given I click link "pickle-rick Weight = 0.0"
    Then I should see "pickle-rick_4"
    # Question create/edit
    Given I click link "pickle-rick_1"
    Then I should see "Business_1_q1"
    Given I edit question "Business_1_q1" into "pickle-rick_1_q1"
    Then I should see "pickle-rick_1_q1 was successfully updated."
    #Given I click link "pickle-rick Weight = 0.0"
    #Given I click link "pickle-rick_1 Weight = 7.7"
    Then I should see "pickle-rick_1_q1"
    Given I create a new question "pickle-rick_1_q4"
    Then I should see "pickle-rick_1_q4 was successfully created."
    #Given I click link "pickle-rick Weight = 0.0"
    #Given I click link "pickle-rick_1 Weight = 7.7"
    Then I should see "pickle-rick_1_q4"
    # Invalid input
    Given I input invalid in "Weight"
    Then I should see "Weight Invalid, you need to type a float."
    # Delete 
    # Given I am on All question page
    # Given I delete the question "pickle-rick"
    # Then I should see "You sure?"
    # Given I comfirm the popup
    # Then I should see "Category 'pickle-rick' deleted."
  
  Scenario: Admin can manage scales
    Given I am on Scales page
    Then I should see "Scales"
    # Filter 
    When I uncheck the following category: Security, Finance
    When I press "Refresh"
    Then I should not see "S trust level 0"
    Then I should not see "F trust level 0"
    When I check the following category: Security, Finance
    When I press "Refresh"
    Then I should see "S trust level 0"
    # Scale create/edit
    Given I edit the first scale into "pickle-rick_scale"
    Then I should see "Scale was successfully updated."
    Then I should see "pickle-rick_scale"
    Then I should see "This is a description for scale"
    Given I create a new scale "pickle-morty_scale"
    Then I should see "Scale was successfully created."
    Then I should see "This is another description for scale"
    # TEST scale delete
    # Given I am on Scales page
    # Given I destroy a scale
    # Given I accept the popup
    # Then I should see "Scale deleted"
  
  Scenario: Admin can manage scenarios
    Given I am on All Scenarios page
    Then I should see "All Scenarios"
    # Create scenario
    Given I create a new scenario "pickle-rick"
    Then I should see "Scenario created!"
    Then I should see "pickle-rick"
    Then I should see "This is a description for scenario"
    # Edit scenario
    Given I am on All Scenarios page
    Given I edit scenario 1 into "pickle-morty"
    Then I should see "pickle-morty was successfully updated."
    Given I am on All Scenarios page
    Then I should see "This is another description for scenario"
    # Asign
    Given I click "Assign" of scenario "pickle-rick"
    Then I should see "All Decision Makers"
    Given I click "Assign" of "Example DM1" and "Exmaple DM2"
    Then I should see "Successfully Assigned!"
    Given I am on All Scenarios page
    Given I click link "pickle-rick"
    Then I should see "Related decision makers"
    Then I should see "Example DM1"
    Then I should see "Example DM2"
    Given I am on All Scenarios page
    Given I click "Assign" of scenario "pickle-rick"
    Given I click "Delete" of "Example DM1"
    Then I should see "Successfully Deleted!"
    Given I am on All Scenarios page
    Given I click link "pickle-rick"
    Then I should not see "Example DM1"
    Then I should see "Example DM2"
    
  Scenario: Admin can invite other people to be an Admin
    Given I am on Invite page
    Then I should see "Invite Administrator"
    Given I invite user "Example Admin2" with email "admin@test.org"
    Then I should see "Send invitation to Administrator."
    Then I should see "You have new users to approve."
    Given I am on All user page
    Then I should see "Example Admin2"
    
  Scenario: Help page
    Given I am on Help page
    Then I should see "Help"
    Then I should see "Contact the Team TreeNewBee @ TAMU for help."
    
  Scenario: Log out
    Given I log out
    Then I should see "Welcome to the TAMURAT"
  
    
    
    
    
  
  
 
