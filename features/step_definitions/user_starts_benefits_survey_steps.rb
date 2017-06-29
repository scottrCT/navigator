Given /^a page for benefits survey$/ do
end

When /^I navigate to Benefits Survey page$/ do
  visit 'surveys/start_new_survey'
end

Then /^I should see "([^\"]*)" header$/ do |text|
  response.should have_selector("div#frm_screening h1.header", :content => text)
  response.should contain("Complete the following survey to learn whether you might be able to get help to pay for things like food, health insurance, and child care.")
end


