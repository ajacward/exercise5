Given /I have added "(.*)" with rating "(.*)"/ do |title, rating|
  steps %Q{
    Given I am on the Create New Movie page
    When  I fill in "Title" with "#{title}"
    And   I select "#{rating}" from "Rating"
    And   I press "Save Changes"
  }
end

Then /I should see "(.*)" on (.*)/ do |string1, path|
  steps %Q{Given I am on #{path}}
  regexp = /#{string1}/m #  /m means match across newlines
  expect(page.body).to match(regexp)
end

Given(/^the following movies exist:$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  table.hashes.each do |movie|
    Movie.create(movie)      
  end
end

Then(/^the director of "([^"]*)" should be "([^"]*)"$/) do |arg1, arg2|
  movie = Movie.find_by_title(arg1)
  expect(movie.director).to eq(arg2)
end
