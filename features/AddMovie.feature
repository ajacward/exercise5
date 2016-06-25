Feature: User can manually add movie
  
  As a movie fan
  So that I can add new movies 
  I want to add movies by manually entering movie titles and ratings

Background: Start from the home page

  Given I am on the RottenPotatoes home page

Scenario: Add a movie

  Given I have added "The Matrix" with rating "R"
  Then  I should see "The Matrix" on the RottenPotatoes home page 
