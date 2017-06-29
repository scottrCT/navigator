Feature: User starts benefits survey
  In order to find all the eligible programs
  As a user
  I want to be able to start benefits survey
  
  Scenario: Start Benefits Survey
    Given a page for benefits survey
    When I navigate to Benefits Survey page
    Then I should see "Benefits Survey" header
    And I should see "Complete the following survey to learn whether you might be able to get help to pay for things like food, health insurance, and child care."
    