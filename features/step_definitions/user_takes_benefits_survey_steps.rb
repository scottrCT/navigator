Given /^I am on "([^\"]*)" page/ do |arg1|
  visit 'surveys/start_new_survey'
end

Given /^I fill "([^\"]*)" with "([^\"]*)"$/ do |arg1, arg2|
  case arg1
    when "age"
      fill_in "How old are you?", :with => arg2
    when "children_under_18"
      #selenium.wait_for_text "How many children (18 and under) live in your house?", :timeout_in_seconds => 10
      fill_in "How many children (18 and under) live in your house?", :with => arg2
    when "adult_dependants"
      fill_in "Besides your spouse/partner, how many adults living with you do you claim as dependants on you tax return?", :with => arg2
    when "net_income_amt"
      fill_in "How much money do you make before taxes and other deductions are taken out and how often do you get paid?", :with => arg2 if !arg2.blank?
    when "spouse_net_income_amt"
      fill_in "How much money does your spouse/partner make before taxes and other deductions are taken out and how often does your spouse/partner get paid?", :with => arg2 if !arg2.blank?
    when "other_income_amt"
      fill_in "About that other income: how much is it? How often?", :with => arg2 if !arg2.blank?
  end
end

Given /^I select "([^\"]*)" for "([^\"]*)" question$/ do |arg1, arg2|
  case arg2
    when "What is your residency status?"
      select arg1, :from => "survey_residency_id"
    when "Do you live in Connecticut?"
      select arg1, :from => "survey_resident_of_CT" 
    when "Do you have a spouse or partner living with you?"
      select arg1, :from => "survey_have_a_spouse"  
    when "Are any of the children living with you are under 5 years old?"
      select arg1, :from => "survey_children_under_5"
    when "Are any of the children living with you are under 13 years old?"
      select arg1, :from => "survey_children_under_13" if !arg1.blank?
    when "Do you, or any adult living with you have any kind of disability?"
      select arg1, :from => "survey_adult_disability"
    when "Is anyone in your household currently pregnant or was pregnant in last 12 months?"
      select arg1, :from => "survey_pregnant"
    when "Are you currently employed?"
      selenium.wait_for_text "Are you currently employed?", :timeout_in_seconds => 10
      select arg1, :from => "survey_currently_employed"
    when "Are you in an approved training activity?"
      select arg1, :from => "survey_approved_training_activity" if !arg1.blank?
    when "How much money do you make before taxes and other deductions are taken out and how often do you get paid?"
      select arg1, :from => "survey_net_income_frequency" if !arg1.blank?
    when "Is your spouse or partner currently employed?"
      select arg1, :from => "survey_spouse_currently_employed" if !arg1.blank?
    when "Is he/she in an approved training activity?"
      select arg1, :from => "survey_spouse_approved_training_activity" if !arg1.blank?
    when "How much money does your spouse/partner make before taxes and other deductions are taken out and how often does your spouse/partner get paid?"
      select arg1, :from => "survey_spouse_net_income_frequency" if !arg1.blank?
    when "Does your household have income from sources other than employment?"
      select arg1, :from => "survey_other_income"
    when "About that other income: how much is it? How often?"
        select arg1, :from => "survey_other_income_frequency" if !arg1.blank?
    when "How will you be filing your taxes this year?"
      select arg1, :from => "survey_tax_filing_method_id"
  end
end

Given /^I click "([^\"]*)" link$/ do |arg1|
  case arg1
    when "Next: Family"
      click_link "nextFamLink"
    when "Next: Income Information"
      click_link "nextIncInfo"
    when "Review Answers"
      click_link "nextReview"
    when "Submit Survey"
      selenium.wait_for_text "Please review and submit if correct...", :timeout_in_seconds => 10
      click_button "submit"
      #selenium.click "//input[@id='submit']"
  end
end

Then /^I should be eligible for "([^\"]*)"$/ do |arg1|
 selenium.wait_for_text "Survey Results", :timeout_in_seconds => 10
 arg1.split(",").each do |prog|
   response.should  contain(prog.strip)
 end 
end


