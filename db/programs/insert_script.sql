INSERT INTO programs (name, description) VALUES ('Connecticut Care 4 Kids', 'Care 4 Kids helps pay for child care for low to moderate income families who are working or in job training.');
INSERT INTO programs (name, description) VALUES ('Earned Income Tax Credit', 'The Earned Income Tax Credit (EITC) is a refundable federal tax benefit for working people with low or moderate incomes. Eligible families or individuals usually receive a tax refund after filing their tax return.');
INSERT INTO programs (name, description) VALUES ('Food Stamps/SNAP', 'The Food Stamp program helps low income households buy food.');
INSERT INTO programs (name, description) VALUES ('SAGA Cash', 'SAGA provides cash to individuals without dependent children in Connecticut who do not have enough money to meet their basic needs and are deemed "unemployable".');
INSERT INTO programs (name, description) VALUES ('SAGA Medical', 'SAGA provides medical insurance to indigent individuals regardless of their employability status.');
INSERT INTO programs (name, description) VALUES ('Husky A: For Children', 'HUSKY (Healthcare for UninSured Kids and Youth) is a managed care health insurance program for children ages 18 and under who are U.S. citizens or legal permanent residents.');
INSERT INTO programs (name, description) VALUES ('Husky A: For Parents/Caregiver Relatives', 'Parents and relative caregivers whose child is insured under HUSKY A and whose income is at or below 185% of the Federal Poverty Level may also be eligible for coverage by HUSKY A.');
INSERT INTO programs (name, description) VALUES ('Husky B: For Children', 'HUSKY (Healthcare for UninSured Kids and Youth) is a managed care health insurance program for uninsured children ages 18 and under who are U.S. citizens or legal permanent residents.');
INSERT INTO programs (name, description) VALUES ('Medicaid', 'Medicaid is a government health insurance program for people who are 65 years of age or older, blind or disabled, children, pregnant women and parents.');
INSERT INTO programs (name, description) VALUES ('Medicaid for the Employed Disabled', 'Connecticut residents who meet Social Security''s definition of disability and are employed may be eligible for Medicaid even if their income and assets are higher than the usual income and asset restrictions for Medicaid.');
INSERT INTO programs (name, description) VALUES ('Medicare', 'Medicare is the federal health insurance program for people 65 years of age and older, and people with disabilities under the age of 65.');
INSERT INTO programs (name, description) VALUES ('Medicare D', 'Medicare Part D, also known as Medicare Rx, is Medicare''s prescription drug program.');
INSERT INTO programs (name, description) VALUES ('Medicare D Low Income Subsidy', 'The Medicare D Low Income Subsidy, also called "Extra Help", helps low income individuals pay for Medicare Part D premiums, deductibles and co-pays.');
INSERT INTO programs (name, description) VALUES ('ConnPACE', 'ConnPACE pays for most prescription drugs for eligible senior citizens and people with disabilities.');
INSERT INTO programs (name, description) VALUES ('Property Tax Credit and Rent Rebate', 'State law provides a property tax credit/rent rebate program for Connecticut homeowners and renters who are elderly or disabled, and whose incomes do not exceed certain limits. The benefit is based on a graduated income scale.');
INSERT INTO programs (name, description) VALUES ('Social Security Disability - SSD', 'SSD pays a monthly benefit to individuals who are unable to work because of their disability. To be eligible, the individual must have worked enough to earn the proper number of "credits" and have paid Social Security taxes.');
INSERT INTO programs (name, description) VALUES ('Supplemental Security Income - SSI', 'SSI pays a monthly benefit amount to low income individuals who are elderly or disabled and who have not earned enough work credits to be eligible for Social Security Retirement or Social Security Disability.');
INSERT INTO programs (name, description) VALUES ('WIC', 'WIC provides specific foods and nutrition education to eligible pregnant women, postpartum women up to six months, breastfeeding women up to one year postpartum, and infants and children up to their fifth birthday.');
INSERT INTO programs (name, description) VALUES ('Utility Assistance - CEAP - CHAP', 'CEAP and CHAP energy assistance programs provide financial assistance for payment of primary heat bills for households with qualifying incomes.  The amount of assistance depends upon household income and family size, type of heat source, and whether heat is included in rent.  CEAP has a renter''s benefit for households whose heat is included in their rent, but CHAP does not.');
INSERT INTO programs (name, description) VALUES ('Temporary Family Assistance - TFA', 'Monthly cash benefit for indigent families with dependent children.  Custodial relatives can receive a child-only TFA grant without regard to the custodial relative''s income.');
INSERT INTO programs (name, description) VALUES ('Operation Fuel', 'Operation Fuel provides cash assistance for payment of heat bill OR non-heat utility bills for qualifying households.');
INSERT INTO programs (name, description) VALUES ('School Breakfast-School Lunch Program', 'Free or reduced price breakfasts and lunches are served in participating elementary and secondary schools to enrolled students whose family income does not exceed income limits.');
INSERT INTO programs (name, description) VALUES ('Healthy Start', 'Healthy Start is an expanded Medicaid program that provides prenatal care and all other medical services for pregnant women whose income is at or below 250% of the federal poverty level. Note: There''s no asset test. Also, take into consideration that a pregnant woman counts as a family of two for this program.');
INSERT INTO programs (name, description) VALUES ('Medicare Savings Programs - QMB - SLMB - ALMB', 'Medicare Savings Programs pay Medicare B premiums.  QMB also pays for Medicare B deductibles and co-pays.');
#---------------------------
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/Care%204%20Kids%20lb.asp' FROM programs WHERE name = 'Connecticut Care 4 Kids';
INSERT INTO program_links (program_id, name, link) SELECT id, 'an application','http://www.ctcare4kids.com/pdf/C4KfinalApplication2.pdf' FROM programs WHERE name = 'Connecticut Care 4 Kids';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/Earned%20Income%20Credit%20pt.asp' FROM programs WHERE name = 'Earned Income Tax Credit';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/Food%20Stamps%20cw.asp' FROM programs WHERE name = 'Food Stamps/SNAP';
INSERT INTO program_links (program_id, name, link) SELECT id, 'an application','http://www.ct.gov/dss/lib/dss/pdfs/w-1food.pdf' FROM programs WHERE name = 'Food Stamps/SNAP';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/SAGA%20Cash%20Assistance%20cw.asp' FROM programs WHERE name = 'SAGA Cash';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/SAGA%20Cash%20Assistance%20cw.asp' FROM programs WHERE name = 'SAGA Medical';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/HUSKYAandHUSKYBcw.asp' FROM programs WHERE name = 'Husky A: For Children';
INSERT INTO program_links (program_id, name, link) SELECT id, 'an application','http://www.huskyhealth.com/hh/cwp/view.asp?a=3573&q=422288&hhNav=|' FROM programs WHERE name = 'Husky A: For Children';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/HUSKYAandHUSKYBcw.asp' FROM programs WHERE name = 'Husky A: For Parents/Caregiver Relatives';
INSERT INTO program_links (program_id, name, link) SELECT id, 'an application','http://www.huskyhealth.com/hh/cwp/view.asp?a=3573&q=422288&hhNav=|' FROM programs WHERE name = 'Husky A: For Parents/Caregiver Relatives';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/HUSKYAandHUSKYBcw.asp' FROM programs WHERE name = 'Husky B: For Children';
INSERT INTO program_links (program_id, name, link) SELECT id, 'an application','http://www.huskyhealth.com/hh/cwp/view.asp?a=3573&q=422288&hhNav=|' FROM programs WHERE name = 'Husky B: For Children';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/Medicaid%20cw.asp' FROM programs WHERE name = 'Medicaid';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/Medicaid%20for%20the%20Employed%20Disabled%20cw.asp' FROM programs WHERE name = 'Medicaid for the Employed Disabled';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/Medicare%20cw.asp' FROM programs WHERE name = 'Medicare';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/Medicare%20cw.asp' FROM programs WHERE name = 'Medicare D';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/Prescription%20Expense%20Assistance%20cw.asp' FROM programs WHERE name = 'Medicare D Low Income Subsidy';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/Prescription%20Expense%20Assistance%20cw.asp' FROM programs WHERE name = 'ConnPACE';
INSERT INTO program_links (program_id, name, link) SELECT id, 'an application','http://www.connpace.com/pubs/index.htm' FROM programs WHERE name = 'ConnPACE';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/PropertyTaxCreditforElderlyorDisabledpt.asp' FROM programs WHERE name = 'Property Tax Credit and Rent Rebate';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.socialsecurity.gov/dibplan/index.htm' FROM programs WHERE name = 'Social Security Disability - SSD';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.socialsecurity.gov/notices/supplemental-security-income/' FROM programs WHERE name = 'Supplemental Security Income - SSI';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/WIC%20cw.asp' FROM programs WHERE name = 'WIC';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/CT_Energy_Assist_Programs.asp' FROM programs WHERE name = 'Utility Assistance - CEAP - CHAP';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/Temporary_Family_Assistance_TFA.asp' FROM programs WHERE name = 'Temporary Family Assistance - TFA';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/Operation%20Fuel%20fj.asp' FROM programs WHERE name = 'Operation Fuel';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/School%20Lunch%20and%20Breakfast%20Programs.asp' FROM programs WHERE name = 'School Breakfast-School Lunch Program';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.infoline.org/InformationLibrary/Documents/HEALTHYSTART.asp' FROM programs WHERE name = 'Healthy Start';
INSERT INTO program_links (program_id, name, link) SELECT id, 'more information','http://www.211ct.org/InformationLibrary/Documents/Medicaresavingsprograms.asp' FROM programs WHERE name = 'Medicare Savings Programs - QMB - SLMB - ALMB';
#---------------------------
#--SELECT 'UPDATE programs SET fpl_max = '||ifnull(fpl_max,-1)||', smi_max='||ifnull(smi_max, -1)||', annual_income_max='||ifnull(annual_income_max,-1)||', method_nm='''||method_nm||''' WHERE name = '''||name||''';' 
#--FROM programs
UPDATE programs SET fpl_max = -1, smi_max=0.75, annual_income_max=-1, method_nm='c4k' WHERE name = 'Connecticut Care 4 Kids';
UPDATE programs SET fpl_max = -1, smi_max=-1, annual_income_max=48279, method_nm='eitc' WHERE name = 'Earned Income Tax Credit';
UPDATE programs SET fpl_max = 1.85, smi_max=-1, annual_income_max=-1, method_nm='snap' WHERE name = 'Food Stamps/SNAP';
UPDATE programs SET fpl_max = -1, smi_max=-1, annual_income_max=2484, method_nm='sagacash' WHERE name = 'SAGA Cash';
UPDATE programs SET fpl_max = 1, smi_max=-1, annual_income_max=-1, method_nm='sagamed' WHERE name = 'SAGA Medical';
UPDATE programs SET fpl_max = 1.85, smi_max=-1, annual_income_max=-1, method_nm='huskya_children' WHERE name = 'Husky A: For Children';
UPDATE programs SET fpl_max = 1.85, smi_max=-1, annual_income_max=-1, method_nm='huskya_parents' WHERE name = 'Husky A: For Parents/Caregiver Relatives';
UPDATE programs SET fpl_max = -1, smi_max=-1, annual_income_max=-1, method_nm='huskyb' WHERE name = 'Husky B: For Children';
UPDATE programs SET fpl_max = 1, smi_max=-1, annual_income_max=-1, method_nm='medicaid' WHERE name = 'Medicaid';
UPDATE programs SET fpl_max = -1, smi_max=-1, annual_income_max=75000, method_nm='medicaid_emp_disabled' WHERE name = 'Medicaid for the Employed Disabled';
UPDATE programs SET fpl_max = -1, smi_max=-1, annual_income_max=-1, method_nm='medicare' WHERE name = 'Medicare';
UPDATE programs SET fpl_max = -1, smi_max=-1, annual_income_max=-1, method_nm='medicared' WHERE name = 'Medicare D';
UPDATE programs SET fpl_max = 1.5, smi_max=-1, annual_income_max=-1, method_nm='medicared_low_income' WHERE name = 'Medicare D Low Income Subsidy';
UPDATE programs SET fpl_max = -1, smi_max=-1, annual_income_max=33800, method_nm='connpace' WHERE name = 'ConnPACE';
UPDATE programs SET fpl_max = -1, smi_max=-1, annual_income_max=39500, method_nm='rent_rebate' WHERE name = 'Property Tax Credit and Rent Rebate';
UPDATE programs SET fpl_max = -1, smi_max=-1, annual_income_max=-1, method_nm='ssd' WHERE name = 'Social Security Disability - SSD';
UPDATE programs SET fpl_max = -1, smi_max=-1, annual_income_max=11160, method_nm='ssi' WHERE name = 'Supplemental Security Income - SSI';
UPDATE programs SET fpl_max = 1.85, smi_max=-1, annual_income_max=-1, method_nm='wic' WHERE name = 'WIC';
UPDATE programs SET fpl_max = -1, smi_max=0.6, annual_income_max=-1, method_nm='chap' WHERE name = 'Utility Assistance - CEAP - CHAP';
UPDATE programs SET fpl_max = 1, smi_max=-1, annual_income_max=-1, method_nm='tfa' WHERE name = 'Temporary Family Assistance - TFA';
UPDATE programs SET fpl_max = 2, smi_max=-1, annual_income_max=-1, method_nm='opfuel' WHERE name = 'Operation Fuel';
UPDATE programs SET fpl_max = 1.85, smi_max=-1, annual_income_max=-1, method_nm='school_lunch' WHERE name = 'School Breakfast-School Lunch Program';
UPDATE programs SET fpl_max = 2.5, smi_max=-1, annual_income_max=-1, method_nm='healthy_start' WHERE name = 'Healthy Start';
UPDATE programs SET fpl_max = 2.32, smi_max=-1, annual_income_max=-1, method_nm='medicare_savings' WHERE name = 'Medicare Savings Programs - QMB - SLMB - ALMB';
#---------------------------
#--select 'INSERT INTO smis (year, family_size, amt) VALUES (2009, '||family_size||', '||amt||');' FROM smis
INSERT INTO smis (year, family_size, amt) VALUES (2009, 1, 50808.16);
INSERT INTO smis (year, family_size, amt) VALUES (2009, 2, 66441.44);
INSERT INTO smis (year, family_size, amt) VALUES (2009, 3, 82074.72);
INSERT INTO smis (year, family_size, amt) VALUES (2009, 4, 97708);
INSERT INTO smis (year, family_size, amt) VALUES (2009, 5, 113341.28);
INSERT INTO smis (year, family_size, amt) VALUES (2009, 6, 128974.56);
INSERT INTO smis (year, family_size, amt) VALUES (2009, 7, 131905.8);
INSERT INTO smis (year, family_size, amt) VALUES (2009, 8, 134837.04);
INSERT INTO smis (year, family_size, amt) VALUES (2009, 9, 137768.28);
INSERT INTO smis (year, family_size, amt) VALUES (2009, 10, 140699.52);
INSERT INTO smis (year, family_size, amt) VALUES (2009, 11, 143630.76);
INSERT INTO smis (year, family_size, amt) VALUES (2009, 12, 146562);
INSERT INTO smis (year, family_size, amt) VALUES (2010, 1, 52854.36);
INSERT INTO smis (year, family_size, amt) VALUES (2010, 2, 69117.24);
INSERT INTO smis (year, family_size, amt) VALUES (2010, 3, 85380.12);
INSERT INTO smis (year, family_size, amt) VALUES (2010, 4, 101643.00);
INSERT INTO smis (year, family_size, amt) VALUES (2010, 5, 117905.88);
INSERT INTO smis (year, family_size, amt) VALUES (2010, 6, 134168.76);
INSERT INTO smis (year, family_size, amt) VALUES (2010, 7, 137218.05);
INSERT INTO smis (year, family_size, amt) VALUES (2010, 8, 140267.34);
INSERT INTO smis (year, family_size, amt) VALUES (2010, 9, 143316.63);
INSERT INTO smis (year, family_size, amt) VALUES (2010, 10, 146365.92);
INSERT INTO smis (year, family_size, amt) VALUES (2010, 11, 149415.21);
INSERT INTO smis (year, family_size, amt) VALUES (2010, 12, 152464.5);
#---------------------------
INSERT INTO eitcs (year, filing_status, children_no, amount) VALUES (2009, 1, 0, 13440);
INSERT INTO eitcs (year, filing_status, children_no, amount) VALUES (2009, 1, 1, 35463);
INSERT INTO eitcs (year, filing_status, children_no, amount) VALUES (2009, 1, 2, 40295);
INSERT INTO eitcs (year, filing_status, children_no, amount) VALUES (2009, 1, 3, 43279);
INSERT INTO eitcs (year, filing_status, children_no, amount) VALUES (2009, 2, 0, 18440);
INSERT INTO eitcs (year, filing_status, children_no, amount) VALUES (2009, 2, 1, 40463);
INSERT INTO eitcs (year, filing_status, children_no, amount) VALUES (2009, 2, 2, 45295);
INSERT INTO eitcs (year, filing_status, children_no, amount) VALUES (2009, 2, 3, 48279);
#---------------------------
#--select 'INSERT INTO fpls (year, base_amt, offset) VALUES ('||year||', '||base_amt||', '||offset||');' FROM fpls
INSERT INTO fpls (year, base_amt, offset) VALUES (2009, 10830, 3740);
INSERT INTO fpls (year, base_amt, offset) VALUES (2010, 10830, 3740);
#---------------------------
INSERT INTO residencies(status) VALUES('US Citizen');
INSERT INTO residencies(status) VALUES('Permanent Resident');
INSERT INTO residencies(status) VALUES('Asylee/Refugee');
INSERT INTO residencies(status) VALUES('Other');
#---------------------------
INSERT INTO tax_filing_methods(tax_method) VALUES('I will not file');
INSERT INTO tax_filing_methods(tax_method) VALUES('Single');
INSERT INTO tax_filing_methods(tax_method) VALUES('Joint');
#---------------------------
INSERT INTO income_frequencies(frequency, annual_multiplier) values('Weekly', 52);
INSERT INTO income_frequencies(frequency, annual_multiplier) values('Biweekly', 26);
INSERT INTO income_frequencies(frequency, annual_multiplier) values('Twice a month', 24);
INSERT INTO income_frequencies(frequency, annual_multiplier) values('Monthly', 12);
INSERT INTO income_frequencies(frequency, annual_multiplier) values('Annually', 1);
#---------------------------
INSERT INTO select_options(id, list_option) VALUES(1, 'Yes');
INSERT INTO select_options(id, list_option) VALUES(0, 'No');
#---------------------------
#-- This is to update the id to 0 as the insert above will give 'No' an id of 2 in MySql.
UPDATE select_options set id = 0 WHERE list_option = 'No';
#---------------------------