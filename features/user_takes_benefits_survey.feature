Feature: User takes benefits survey
  In order to find all the eligible programs
  As a user
  I want to take benefits survey
  
  Scenario Outline: Determine eligibility 
  Given I am on Benefits Survey page
  And I fill "age" with "<age>"
  And I select "<residency_status>" for "What is your residency status?" question
  And I select "<CT_Resident>" for "Do you live in Connecticut?" question
  And I select "<have_a_spouse>" for "Do you have a spouse or partner living with you?" question
  And I click "Next: Family" link
  And I fill "children_under_18" with "<children_under_18>"
  And I select "<children_under_5>" for "Are any of the children living with you are under 5 years old?" question
  And I select "<children_under_13>" for "Are any of the children living with you are under 13 years old?" question
  And I fill "adult_dependants" with "<adult_dependants>"
  And I select "<adult_disability>" for "Do you, or any adult living with you have any kind of disability?" question
  And I select "<pregnant>" for "Is anyone in your household currently pregnant or was pregnant in last 12 months?" question
  And I click "Next: Income Information" link
  And I select "<currently_employed>" for "Are you currently employed?" question
  And I select "<approved_training_activity>" for "Are you in an approved training activity?" question
  And I fill "net_income_amt" with "<net_income_amt>"
  And I select "<net_income_frequency>" for "How much money do you make before taxes and other deductions are taken out and how often do you get paid?" question
  And I select "<spouse_currently_employed>" for "Is your spouse or partner currently employed?" question
  And I select "<spouse_approved_training_activity>" for "Is he/she in an approved training activity?" question
  And I fill "spouse_net_income_amt" with "<spouse_net_income_amt>"
  And I select "<spouse_net_income_frequency>" for "How much money does your spouse/partner make before taxes and other deductions are taken out and how often does your spouse/partner get paid?" question
  And I select "<other_income>" for "Does your household have income from sources other than employment?" question
  And I fill "other_income_amt" with "<other_income_amt>"
  And I select "<other_income_frequency>" for "About that other income: how much is it? How often?" question
  And I select "<tax_filing_method>" for "How will you be filing your taxes this year?" question
  And I click "Review Answers" link 
  And I click "Submit Survey" link 
  Then I should be eligible for "<programs>"
  
    Scenarios: 
	  | age | residency_status 	 | CT_Resident | have_a_spouse | children_under_18 | children_under_5 | children_under_13 | adult_dependants | adult_disability | pregnant | currently_employed | net_income_amt | net_income_frequency | approved_training_activity |spouse_currently_employed | spouse_net_income_amt | spouse_net_income_frequency | spouse_approved_training_activity | other_income | other_income_amt | other_income_frequency | tax_filing_method | programs 			     |
      | 31  | US Citizen       	 | Yes		   | No			   | 1                 | Yes              |    				  | 0                | No               | No	   | Yes                | 500            | Monthly              |                            |						    |  					    |         					  |                                   | No		     |                  | Monthly		         | Single	         | Husky A: For Children     |
	  | 25  | US Citizen       	 | Yes         | No            | 2                 | Yes              |                   | 0                | No               | Yes      | Yes                | 320            | Weekly               |                            |                          |                       |                             |                                   | Yes          | 100              | Weekly                 | Single            | Connecticut Care 4 Kids,Earned Income Tax Credit,Food Stamps/SNAP,Husky A: For Children,Husky A: For Parents/Caregiver Relatives,Operation Fuel,School Breakfast-School Lunch Program,Utility Assistance - CEAP - CHAP,WIC |
 	  | 25  | Other	           	 | Yes         | No            | 1                 | Yes              |                   | 0                | Yes              | Yes      | Yes                | 250            | Weekly               |                            |                          |                       |                             |                                   | Yes          | 100              | Weekly                 | Single            | Connecticut Care 4 Kids,Husky A: For Children,Operation Fuel,School Breakfast-School Lunch Program,WIC |
 	  | 55  | US Citizen       	 | Yes         | No            | 0                 |                  |                   | 0                | Yes              | No       | No                 |                |                      | No                         |                          |                       |                             |                                   | Yes 		 | 200              | Weekly                 | Single            | ConnPACE,Food Stamps/SNAP,,Medicaid,Medicare,Medicare D,Medicare D Low Income Subsidy,Medicare Savings Programs - QMB - SLMB - ALMB,Operation Fuel,Property Tax Credit and Rent Rebate,SAGA Medical,Social Security Disability - SSD,Supplemental Security Income - SSI,Utility Assistance - CEAP - CHAP | 
 	  | 75  | US Citizen       	 | Yes         | Yes           | 0                 |                  |                   | 0                | Yes              | No       | No                 |                |                      | No                         | Yes                      | 400                   | Weekly                      |                                   | Yes          | 200              | Weekly                 | Joint             | ConnPACE,Medicaid for the Employed Disabled,Medicare,Medicare D,Medicare Savings Programs - QMB - SLMB - ALMB,Property Tax Credit and Rent Rebate,Utility Assistance - CEAP - CHAP |
 	  | 32  | Permanent Resident | Yes         | Yes           | 4                 | Yes              |                   | 1                | No               | No       | Yes                | 800            | Weekly               |                            | Yes                      | 500                   | Weekly                      |                                   | No           |                  |                        | Joint             | Connecticut Care 4 Kids,Husky B: For Children,Utility Assistance - CEAP - CHAP |
  	  | 54  | US Citizen       	 | Yes         | No            | 1                 | No               | Yes               | 0                | No               | No       | Yes                | 700            | Weekly               |                            |                          |                       |                             |                                   | No           |                  |                        | Single            | Connecticut Care 4 Kids,Husky B: For Children,Utility Assistance - CEAP - CHAP |
 	  | 48  | US Citizen       	 | Yes         | Yes           | 2                 | No               | Yes               | 0                | No               | No       | Yes                | 500            | Weekly               |                            | No                       |                       |                             | Yes                               | No           |                  |                        | Joint             | Connecticut Care 4 Kids,Earned Income Tax Credit,Food Stamps/SNAP,Husky A: For Children,Husky A: For Parents/Caregiver Relatives,Operation Fuel,School Breakfast-School Lunch Program,Utility Assistance - CEAP - CHAP |
	  | 42  | US Citizen      	 | Yes         | Yes           | 2                 | No               | Yes               | 0                | No               | Yes      | Yes                | 400            | Weekly               |                            | No                       |                       |                             | Yes                               | No           |                  |                        | Joint			 | Connecticut Care 4 Kids,Earned Income Tax Credit,Food Stamps/SNAP,Husky A: For Children,Husky A: For Parents/Caregiver Relatives,Operation Fuel,School Breakfast-School Lunch Program,Temporary Family Assistance - TFA,Utility Assistance - CEAP - CHAP,WIC |
	  | 66  | Asylee/Refugee   	 | Yes         | Yes           | 0                 |                  |                   | 0                | Yes              | No       | No                 |                |                      | No                         | No                       |                       |                             | No                                | Yes          | 375              | Weekly                 | Joint             | ConnPACE,Food Stamps/SNAP,Medicare,Medicare D,Medicare D Low Income Subsidy,Medicare Savings Programs - QMB - SLMB - ALMB,Operation Fuel,Property Tax Credit and Rent Rebate,Utility Assistance - CEAP - CHAP |
	  | 61  | US Citizen       	 | Yes         | No            | 0                 |                  |                   | 1                | Yes              | No       | No                 |                |                      | No                         |                          |                       |                             |                                   | Yes          | 300              | Weekly                 | Single            | ConnPACE,Food Stamps/SNAP,Medicare,Medicare D,Medicare D Low Income Subsidy,Medicare Savings Programs - QMB - SLMB - ALMB,Operation Fuel,Property Tax Credit and Rent Rebate,Social Security Disability - SSD,Utility Assistance - CEAP - CHAP | 
	  
	  
	  
	  
	  