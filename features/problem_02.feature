Feature: Problem 02 - Twitter Post
  Scenario:
    Given an end user logs in to their Twitter account with valid credentials
    When that user types “Hello World!” into the post field and clicks submit
    Then a tweet containing the entered text will be posted.