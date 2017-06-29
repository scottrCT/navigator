Feature: View available programs
  In order to know all the programs that 211 offers
  As a user
  I want a list of all available programs
  
  Scenario Outline: View all programs
    Given a webpage for programs
    When I navigate to Programs page
    Then I should see "<program>" program
  
  Scenarios: Programs
  | program                                  	  |
  | Connecticut Care 4 Kids                  	  |
  | Earned Income Tax Credit                	  |
  | Food Stamps/SNAP                         	  |
  | SAGA Cash                                	  |
  | SAGA Medical                             	  |
  | Husky A: For Children                    	  |
  | Husky A: For Parents/Caregiver Relatives 	  |
  | Husky B: For Children                    	  |
  | Medicaid								 	  |
  | Medicaid for the Employed Disabled		 	  |
  | Medicare								 	  |
  | Medicare D								 	  |
  | Medicare D Low Income Subsidy			 	  |
  | ConnPACE								 	  |
  | Property Tax Credit and Rent Rebate		 	  |
  | Social Security Disability - SSD		 	  |
  | Supplemental Security Income - SSI		 	  |
  | WIC										 	  |
  | Utility Assistance - CEAP - CHAP		 	  |
  | Temporary Family Assistance - TFA		 	  |
  | Operation Fuel							 	  |
  | School Breakfast-School Lunch Program	      |
  | Healthy Start								  |
  | Medicare Savings Programs - QMB - SLMB - ALMB |
  