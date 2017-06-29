Given /^a webpage for programs$/ do
end

When /^I navigate to Programs page$/ do
  visit 'programs/index'
end

Then /^I should see "([^\"]*)" program$/ do |prog|
  visit 'programs/index'
  response.should contain(prog)

# This will be more specific test as it checks page elements. That's why I am commenting this out.
# Just keeping it here so that I can refer this if I want to do similar checking in future.
#  response.should have_selector("div#programsListed ul") do |ul|
#    ul.should have_selector("li span.programName", :name => prog)
#  end
end

