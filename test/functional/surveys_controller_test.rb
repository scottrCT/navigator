require 'test/test_helper'

class SurveysControllerTest < ActionController::TestCase
  
  def setup
    @res_status = Residency.find(:all, :order => "id")
    @dropdown_options = SelectOption.find(:all, :order => "id")    
    @valid_survey = surveys(:valid_survey)
    @tax_filing_method = TaxFilingMethod.find(:all, :order => "id")
    @income_frequency = IncomeFrequency.find(:all, :order => "id")    
  end
########################################################################################################################################################################
  # Test survey index page.
  test "surveys_index_page" do
    get :index
    
    assert_response :success
    assert_template "index"

    # Verify page title.
    assert_select "title", "211 Navigator - United Way of Connecticut"
    
    # Verify that there are 5 image tags in index page.
    assert_select "img", 5
    
    # Index page contains no forms.
    assert_select "form", false, "This page must contain no forms"
    
    # Verify that all the contents are rendered within tab.
    assert_select "body > div#main_tabnav ~ div#main_tabnav_content"
    
    # verify the page header.
    assert_select "h1[class=header]", "Welcome to the 2-1-1 Navigator"
    
    # Verify that the footer is rendered at the end and also the DOM.
    assert_select "body > div#header ~ div#main_tabnav ~ div#main_tabnav_content ~ div#footer"
  end
########################################################################################################################################################################  
  # Test survey index page images.
  test "surveys_index_page_images" do
    get :index
    
    assert_response :success
    assert_template "index"
    
    # All image tags must have alt attribute.
    assert_select "img" do
      assert_select "[alt=?]", /.+/  # Not empty
    end
    
    # All image tags must have source attribute.
    assert_select "img" do
      assert_select "[src=?]", /.+/  # Not empty
    end
    
    # Verify all the header images.
    assert_select "img[alt=United Way of Connecticut][src^=/images/uwc.jpg][height=55][width=358]"
    assert_select "img[alt=211][src^=/images/211.jpg][height=57][width=184]"
    assert_select "img[alt=United Way][src^=/images/uwrgbful.jpg][height=57][width=132]"
    
    #Verify the "Related Links" image.
    assert_select "img[alt=Related Links][src^=/images/related.gif]"
    
    # Verify 211 Navigation logo.
    assert_select "img[alt=Go to the Benefits Survey][src^=/images/211NavLogo.jpg][title=Click to go to the benefits survey]"
  end
########################################################################################################################################################################
  # Test all the links on survey index page, excluding "Navigation" and "Related Links".
  # We will test them separately.
  test "surveys_index_page_links" do
    get :index

    assert_response :success
    assert_template "index"
    
    # Verify the header links along with images.
    # Verify "United Way of Connecticut - 211 Navigator" logo link along with image tag.
    assert_select "div#header" do
      assert_select "span[class=leftHead]" do
        assert_select "a[href=/][style^=text-decoration: none]" do
          assert_select "img[alt=United Way of Connecticut][src^=/images/uwc.jpg][height=55][width=358]"
        end
      end
    end
    
    # Verify "211" logo link along with image tag.        
    assert_select "div#header" do
      assert_select "span[class=rightHead]" do
        assert_select "a[href=http://www.ctunitedway.org/][style^=text-decoration: none]" do
          assert_select "img[alt=United Way][src^=/images/uwrgbful.jpg][height=57][width=132]"
        end
      end
    end
    
    # Verify "United Way" logo link along with image tag.        
    assert_select "div#header" do
      assert_select "span[class=rightHead]" do
        assert_select "a[href=http://www.211ct.org/][style^=text-decoration: none]" do
          assert_select "img[alt=211][src^=/images/211.jpg][height=57][width=184]"
        end
      end
    end
    
    # Verify "Go the  Benefits Survey" link.
    assert_select "div.mainContentArea > div#links ~ div" do
      assert_select "span[style^=float: left; font-size: 10px; color: darkblue;]"   do
        assert_select "a[href=/surveys/start_new_survey]" do
          assert_select "img[alt=Go to the Benefits Survey][src^=/images/211NavLogo.jpg][title=Click to go to the benefits survey]"
        end
      end
    end
    
    # Verify footer links.
    assert_select "div#footer a" do
      assert_select "a[href=http://www.ctunitedway.org][target=_blank]", "United Way of Connecticut"
      assert_select "a[href=http://www.cthousingchoice.com/UWCTerms.html]", "Terms and Conditions"
    end
    
  end
########################################################################################################################################################################  
  # Test the navigation links on index page.
  test "surveys_index_page_navigation_links" do
    get :index

    assert_response :success
    assert_template "index"
    
    # Verify navigation links.
    assert_select "div#main_tabnav > ul > li" do
      assert_select "li[class*=active]" do # Verify "Home" tab is selected for Survey controller index action by inspecting class attribute.
        assert_select "a[class*=active][title=Home][href=/]", "Home" # Verify "Home" tab is selected for Survey controller index action by inspecting class attribute.
      end
      assert_select "li[class='']" do
        assert_select "a[class=''][title=Programs][href=/programs]", "Programs"
      end
      assert_select "li[class='']" do
        assert_select "a[class=''][title=Benefits Survey][href=/surveys/start_new_survey]", "Benefits Survey"
      end
#      assert_select "li[class='']" do
#        assert_select "a[class=''][title=Feedback][href=/comment/new]", "Feedback"
#      end
    end
  end
########################################################################################################################################################################
  # Test "Related Links" on index page.
  test "surveys_index_page_related_links" do
    get :index

    assert_response :success
    assert_template "index"
    
    assert_select "div.mainContentArea > div#links > ul" do
      assert_select "li" do
        assert_select "img[src^=/images/related.gif][alt=Related Links]"
      end
      assert_select "li" do
        assert_select "a[target=_blank][href=http://www.ctunitedway.org][title=The United Way of Connecticut Home Page]","United Way of CT"
      end
      assert_select "li" do
        assert_select "a[target=_blank][href=http://www.ctunitedway.org/Who/CTUWays.asp][title=Your Local United Ways]","Local United Ways"
      end
      assert_select "li" do
        assert_select "a[target=_blank][href=http://www.211ct.org][title=Need any kind of help? Dial 2-1-1!]","211"
      end
      assert_select "li" do
        assert_select "a[target=_blank][href=http://www.ctcare4kids.com][title=Connecticut DSS Care 4 Kids]","CT Care 4 Kids"
      end
    end
  end
########################################################################################################################################################################  
  # Test Benefits Survey page.
  test "benefits_survey_page" do
    get :start_new_survey

    assert_response :success
    assert_template "start_new_survey"
    
    # Verify page title.
    assert_select "title", "211 Navigator - United Way of Connecticut"
    
    # Verify that there are 4 image tags in index page.
    assert_select "img", 4
    
    # Index page contains one form.
    assert_select "form#new_survey[class=new_survey][method=post][action=/surveys/create]", 1
    
    # Verify that all the contents are rendered within tab.
    assert_select "body > div#main_tabnav ~ div#main_tabnav_content"
    
    # verify the page header.
    assert_select "h1[class=header]", "Benefits Survey"

    # verify the page sub header.
    assert_select "h2[class=subheader]", "Complete the following survey to learn whether you might be able to get help to pay for things like food, health insurance, and child care.\n\nCompleting the survey is quick, and easy. All you have to do is either enter a number in a box, or pick an option from a pre-set list.\nIf you get stuck on a question, look for text with a dotted underline, and try rolling your mouse over it."
    
    # Verify that the survey tab is displayed within main tab.
    assert_select "div#main_tabnav ~ div#main_tabnav_content div#frm_screening form#new_survey div#survey_tabnav ~ div#survey_tabnav_content"
    
    # Verify that the footer is rendered at the end and also the DOM.
    assert_select "body > div#header ~ div#main_tabnav ~ div#main_tabnav_content ~ div#footer"
  end
########################################################################################################################################################################
  # Test "Your Details" tab content.
  test "benefits_survey_your_deatils_tab" do
    get :start_new_survey

    assert_response :success
    assert_template "start_new_survey"
    
    # Verify that according to your sections is not present.
    assert_select "div#screening_details", ""
    
    assert_select "div#survey_tabnav_content" do
      assert_select "p label[for=survey_age]", "How old are you?"
      assert_select "p input#survey_age[type=text][name='survey[age]']"
      
      assert_select "p label[for=survey_residency_id]", "What is your residency status?"
      assert_select "select#survey_residency_id option:nth-of-type(1)", "---Select One---"
      assert_select "p select#survey_residency_id[name='survey[residency_id]']" do
        @res_status.each do |res|
          assert_select "option[value=#{res.id.to_s}]", res.status.to_s
        end
      end
      
      assert_select "p label[for=survey_resident_of_CT]", "Do you live in Connecticut?"
      assert_select "select#survey_resident_of_CT option:nth-of-type(1)", "---Select One---"
      assert_select "p select#survey_resident_of_CT[name='survey[resident_of_CT]']" do
        @dropdown_options.each do |opt|
          assert_select "option[value=#{opt.id.to_s}]", opt.list_option.to_s
        end
      end
      
      assert_select "p label[for=survey_have_a_spouse]", "Do you have a spouse or partner living with you?"
      assert_select "select#survey_have_a_spouse option:nth-of-type(1)", "---Select One---"
      assert_select "p select#survey_have_a_spouse[name='survey[have_a_spouse]']" do
        @dropdown_options.each do |opt|
          assert_select "option[value=#{opt.id.to_s}]", opt.list_option.to_s
        end
      end
      
      # Verify hidden elements.
      assert_select "input#survey_children_under_18[name='survey[children_under_18]'][type=hidden]"
      assert_select "input#survey_children_under_13[name='survey[children_under_13]'][type=hidden]"
      assert_select "input#survey_children_under_5[name='survey[children_under_5]'][type=hidden]"
      assert_select "input#survey_adult_dependants[name='survey[adult_dependants]'][type=hidden]"
      assert_select "input#survey_adult_disability[name='survey[adult_disability]'][type=hidden]"
      assert_select "input#survey_pregnant[name='survey[pregnant]'][type=hidden]"
  
      assert_select "input#survey_currently_employed[name='survey[currently_employed]'][type=hidden]"
      assert_select "input#survey_spouse_currently_employed[name='survey[spouse_currently_employed]'][type=hidden]"
      assert_select "input#survey_other_income[name='survey[other_income]'][type=hidden]"
      assert_select "input#survey_tax_filing_method_id[name='survey[tax_filing_method_id]'][type=hidden]"
      assert_select "input#survey_approved_training_activity[name='survey[approved_training_activity]'][type=hidden]"
      assert_select "input#survey_spouse_approved_training_activity[name='survey[spouse_approved_training_activity]'][type=hidden]"
      assert_select "input#survey_net_income_amt[name='survey[net_income_amt]'][type=hidden]"
      assert_select "input#survey_net_income_frequency[name='survey[net_income_frequency]'][type=hidden]"  
      assert_select "input#survey_spouse_net_income_amt[name='survey[spouse_net_income_amt]'][type=hidden]"

      assert_select "input#survey_spouse_net_income_frequency[name='survey[spouse_net_income_frequency]'][type=hidden]"    
      assert_select "input#survey_other_income_amt[name='survey[other_income_amt]'][type=hidden]"  
      assert_select "input#survey_other_income_frequency[name='survey[other_income_frequency]'][type=hidden]"

      # Verify the link to go to next tab.
      assert_select "a#nextFamLink[class=buttonLink][onclick^='new Ajax.Updater('survey_questions', '/surveys/get_family_details'][href=#]" 
      assert_select "a#nextFamLink > img#nextFamInfo[src^=/images/nextFamilyInfo.jpg][alt=Next: Family Information]"
    end
  end
########################################################################################################################################################################
  # Test "Family Details" tab content.
  test "benefits_survey_family_deatils_tab" do
   
    # Send an ajax request to go to "Family Details" tab.
    xhr :get, :get_family_details, :survey => { :age                                => @valid_survey.age,
                                                :residency_id                       => @valid_survey.residency_id,
                                                :resident_of_CT                     => @valid_survey.resident_of_CT,
                                                :have_a_spouse                      => @valid_survey.have_a_spouse,
                                                :children_under_18                  => nil,
                                                :adult_dependants                   => nil,
                                                :children_under_13                  => nil,
                                                :children_under_5                   => nil,
                                                :adult_disability                   => nil,
                                                :pregnant                           => nil,
                                                :currently_employed                 => nil,
                                                :spouse_currently_employed          => nil,
                                                :other_income                       => nil,
                                                :tax_filing_method_id               => nil,
                                                :approved_training_activity         => nil,
                                                :spouse_approved_training_activity  => nil,
                                                :net_income_amt                     => nil,
                                                :net_income_frequency               => nil,
                                                :spouse_net_income_amt              => nil,
                                                :spouse_net_income_frequency        => nil,
                                                :other_income_amt                   => nil,
                                                :other_income_frequency             => nil }     

    survey = assigns(:survey)                                                  
    assert_not_nil survey

    assert_response :success
    assert_template "_get_family_details"
    
    # Verify partial elements.
    assert_select "p label[for=survey_children_under_18]", "How many children (18 and under) live in your house?"
    assert_select "p input#survey_children_under_18[type=text][name='survey[children_under_18]']"
    
    assert_select "div[id=children_under_5]" do
      assert_select "p label[for=survey_children_under_5]", "Are any of the children living with you are under 5 years old?"
      assert_select "select#survey_children_under_5 option:nth-of-type(1)", ""
      assert_select "p select#survey_children_under_5[name='survey[children_under_5]']" do
        @dropdown_options.each do |opt|
          assert_select "option[value=#{opt.id.to_s}]", opt.list_option.to_s
        end
      end
    end
    
    assert_select "div[id=children_under_13]" do
      assert_select "p label[for=survey_children_under_13]", "Are any of the children living with you are under 13 years old?"
      assert_select "select#survey_children_under_13 option:nth-of-type(1)", ""
      assert_select "p select#survey_children_under_13[name='survey[children_under_13]']" do
        @dropdown_options.each do |opt|
          assert_select "option[value=#{opt.id.to_s}]", opt.list_option.to_s
        end
      end
    end

    assert_select "p label[for=survey_adult_dependants]", "Besides your spouse/partner, how many adults living with you do you claim as dependants on you tax return?"
    assert_select "p input#survey_adult_dependants[type=text][name='survey[adult_dependants]']"
    
    assert_select "p label[for=survey_adult_disability]", "Do you, or any adult living with you have any kind of disability?"
    assert_select "select#survey_adult_disability option:nth-of-type(1)", "---Select One---"
    assert_select "p select#survey_adult_disability[name='survey[adult_disability]']" do
      @dropdown_options.each do |opt|
        assert_select "option[value=#{opt.id.to_s}]", opt.list_option.to_s
      end
    end

    assert_select "p label[for=survey_pregnant]", "Is anyone in your household currently pregnant or was pregnant in last 12 months?"
    assert_select "select#survey_pregnant option:nth-of-type(1)", "---Select One---"
    assert_select "p select#survey_pregnant[name='survey[pregnant]']" do
      @dropdown_options.each do |opt|
        assert_select "option[value=#{opt.id.to_s}]", opt.list_option.to_s
      end
    end
    
    # Verify hidden elements.
    assert_select "input#survey_age[name='survey[age]'][type=hidden][value=#{@valid_survey.age.to_s}]"
    assert_select "input#survey_residency_id[name='survey[residency_id]'][type=hidden][value=#{@valid_survey.residency_id.to_s}]"
    assert_select "input#survey_resident_of_CT[name='survey[resident_of_CT]'][type=hidden][value=#{@valid_survey.resident_of_CT.to_s}]"
    assert_select "input#survey_have_a_spouse[name='survey[have_a_spouse]'][type=hidden][value=#{@valid_survey.have_a_spouse.to_s}]"
  
    assert_select "input#survey_currently_employed[name='survey[currently_employed]'][type=hidden]"
    assert_select "input#survey_spouse_currently_employed[name='survey[spouse_currently_employed]'][type=hidden]"
    assert_select "input#survey_other_income[name='survey[other_income]'][type=hidden]"
    assert_select "input#survey_tax_filing_method_id[name='survey[tax_filing_method_id]'][type=hidden]"
    assert_select "input#survey_approved_training_activity[name='survey[approved_training_activity]'][type=hidden]"
    assert_select "input#survey_spouse_approved_training_activity[name='survey[spouse_approved_training_activity]'][type=hidden]"
    assert_select "input#survey_net_income_amt[name='survey[net_income_amt]'][type=hidden]"
    assert_select "input#survey_net_income_frequency[name='survey[net_income_frequency]'][type=hidden]"  
    assert_select "input#survey_spouse_net_income_amt[name='survey[spouse_net_income_amt]'][type=hidden]"

    assert_select "input#survey_spouse_net_income_frequency[name='survey[spouse_net_income_frequency]'][type=hidden]"    
    assert_select "input#survey_other_income_amt[name='survey[other_income_amt]'][type=hidden]"  
    assert_select "input#survey_other_income_frequency[name='survey[other_income_frequency]'][type=hidden]"  
    
    # Verify the link to go to next tab.
    assert_select "a.active[onclick^='new Ajax.Updater('survey_questions', '/surveys/get_financial_details'][href=#]" 
    assert_select "a.active > img[src^=/images/backYourInfo.jpg][alt=Back to Your Information]"
    
    # Verify the link to go to previous tab.
    assert_select "a.active[onclick^='new Ajax.Updater('survey_questions', '/surveys/get_self_details'][href=#]" 
    assert_select "a.active > img[src^=/images/nextIncome.jpg][alt=Next: Income Information]"
   
  end
########################################################################################################################################################################
  # Test "Income Details" tab content.
  test "benefits_survey_financial_deatils_tab" do
   
    # Send an ajax request to go to "Income Details" tab.
    xhr :get, :get_financial_details, :survey => { :age                                => @valid_survey.age,
                                                   :residency_id                       => @valid_survey.residency_id,
                                                   :resident_of_CT                     => @valid_survey.resident_of_CT,
                                                   :have_a_spouse                      => @valid_survey.have_a_spouse,
                                                   :children_under_18                  => @valid_survey.children_under_18,
                                                   :adult_dependants                   => @valid_survey.adult_dependants,
                                                   :children_under_13                  => @valid_survey.children_under_13,
                                                   :children_under_5                   => @valid_survey.children_under_5,
                                                   :adult_disability                   => @valid_survey.adult_disability,
                                                   :pregnant                           => @valid_survey.pregnant,
                                                   :currently_employed                 => nil,
                                                   :spouse_currently_employed          => nil,
                                                   :other_income                       => nil,
                                                   :tax_filing_method_id               => nil,
                                                   :approved_training_activity         => nil,
                                                   :spouse_approved_training_activity  => nil,
                                                   :net_income_amt                     => nil,
                                                   :net_income_frequency               => nil,
                                                   :spouse_net_income_amt              => nil,
                                                   :spouse_net_income_frequency        => nil,
                                                   :other_income_amt                   => nil,
                                                   :other_income_frequency             => nil }     

    survey = assigns(:survey)                                                  
    assert_not_nil survey

    assert_response :success
    assert_template "_get_finanancial_details"  
    
    # Verify partial elements.    
    assert_select "p label[for=survey_currently_employed]", "Are you currently employed?"
    assert_select "select#survey_currently_employed option:nth-of-type(1)", "---Select One---"
    assert_select "p select#survey_currently_employed[name='survey[currently_employed]']" do
      @dropdown_options.each do |opt|
        assert_select "option[value=#{opt.id.to_s}]", opt.list_option.to_s
      end
    end
    
    assert_select "div[id=personal_net_income]" do
      assert_select "p label[for=survey_net_income_amt]", "How much money do you make before taxes and other deductions are taken out and how often do you get paid?"
      assert_select "p input#survey_net_income_amt[type=text][name='survey[net_income_amt]']"      
      assert_select "select#survey_net_income_frequency option:nth-of-type(1)", "---Select One---"
      assert_select "p select#survey_net_income_frequency[name='survey[net_income_frequency]']" do
        @income_frequency.each do |inf|
          assert_select "option[value=#{inf.frequency.to_s}]", inf.frequency.to_s
        end
      end
    end 

    assert_select "div[id=self_training_activity]" do
      assert_select "p label[for=survey_approved_training_activity]", "Are you in an approved training activity?"
      assert_select "select#survey_approved_training_activity option:nth-of-type(1)", "---Select One---"
      assert_select "p select#survey_approved_training_activity[name='survey[approved_training_activity]']" do
        @dropdown_options.each do |opt|
          assert_select "option[value=#{opt.id.to_s}]", opt.list_option.to_s
        end
      end
    end 

    assert_select "p label[for=survey_spouse_currently_employed]", "Is your spouse or partner currently employed?"
    assert_select "select#survey_spouse_currently_employed option:nth-of-type(1)", "---Select One---"
    assert_select "p select#survey_spouse_currently_employed[name='survey[spouse_currently_employed]']" do
      @dropdown_options.each do |opt|
        assert_select "option[value=#{opt.id.to_s}]", opt.list_option.to_s
      end
    end

    assert_select "div[id=spouse_net_income]" do
      assert_select "p label[for=survey_spouse_net_income_amt]", "How much money does your spouse/partner make before taxes and other deductions are taken out and how often does your spouse/partner get paid?"
      assert_select "p input#survey_spouse_net_income_amt[type=text][name='survey[spouse_net_income_amt]']"      
      assert_select "select#survey_spouse_net_income_frequency option:nth-of-type(1)", "---Select One---"
      assert_select "p select#survey_spouse_net_income_frequency[name='survey[spouse_net_income_frequency]']" do
        @income_frequency.each do |inf|
          assert_select "option[value=#{inf.frequency.to_s}]", inf.frequency.to_s
        end
      end
    end

    assert_select "div[id=spouse_training_activity]" do
      assert_select "p label[for=survey_spouse_approved_training_activity]", "Is he/she in an approved training activity?"
      assert_select "select#survey_spouse_approved_training_activity option:nth-of-type(1)", "---Select One---"
      assert_select "p select#survey_spouse_approved_training_activity[name='survey[spouse_approved_training_activity]']" do
        @dropdown_options.each do |opt|
          assert_select "option[value=#{opt.id.to_s}]", opt.list_option.to_s
        end
      end
    end

    assert_select "p label[for=survey_other_income]", "Does your household have income from sources other than employment?"
    assert_select "select#survey_other_income option:nth-of-type(1)", "---Select One---"
    assert_select "p select#survey_other_income[name='survey[other_income]']" do
      @dropdown_options.each do |opt|
        assert_select "option[value=#{opt.id.to_s}]", opt.list_option.to_s
      end
    end

    assert_select "div[id=other_net_income]" do
      assert_select "p label[for=survey_other_income_amt]", "About that other income: how much is it? How often?"
      assert_select "select#survey_other_income_frequency option:nth-of-type(1)", "---Select One---"
      assert_select "p select#survey_other_income_frequency[name='survey[other_income_frequency]']" do
        @income_frequency.each do |inf|
          assert_select "option[value=#{inf.frequency.to_s}]", inf.frequency.to_s
        end
      end
    end

    assert_select "p label[for=survey_tax_filing_method_id]", "How will you be filing your taxes this year?"
    assert_select "select#survey_tax_filing_method_id option:nth-of-type(1)", "---Select One---"
    assert_select "p select#survey_tax_filing_method_id[name='survey[tax_filing_method_id]']" do
      @tax_filing_method.each do |tfm|
        assert_select "option[value=#{tfm.id.to_s}]", tfm.tax_method.to_s
      end
    end

    # Verify hidden elements.
    assert_select "input#survey_age[name='survey[age]'][type=hidden][value=#{@valid_survey.age.to_s}]"
    assert_select "input#survey_residency_id[name='survey[residency_id]'][type=hidden][value=#{@valid_survey.residency_id.to_s}]"
    assert_select "input#survey_resident_of_CT[name='survey[resident_of_CT]'][type=hidden][value=#{@valid_survey.resident_of_CT.to_s}]"
    assert_select "input#survey_have_a_spouse[name='survey[have_a_spouse]'][type=hidden][value=#{@valid_survey.have_a_spouse.to_s}]"
    
    assert_select "input#survey_children_under_18[name='survey[children_under_18]'][type=hidden][value=#{@valid_survey.children_under_18.to_s}]"
    assert_select "input#survey_children_under_13[name='survey[children_under_13]'][type=hidden]"
    assert_select "input#survey_children_under_5[name='survey[children_under_5]'][type=hidden][value=#{@valid_survey.children_under_5.to_s}]"
    assert_select "input#survey_adult_dependants[name='survey[adult_dependants]'][type=hidden][value=#{@valid_survey.adult_dependants.to_s}]"
    assert_select "input#survey_adult_disability[name='survey[adult_disability]'][type=hidden][value=#{@valid_survey.adult_disability.to_s}]"
    assert_select "input#survey_pregnant[name='survey[pregnant]'][type=hidden][value=#{@valid_survey.pregnant.to_s}]"

    # Verify the link to go to next tab.
    assert_select "a.active[onclick^='new Ajax.Updater('survey_questions', '/surveys/get_family_details'][href=#]" 
    assert_select "a.active > img[src^=/images/backFamilyInfo.jpg][alt=Back to Family Information]"
    
    # Verify the link to go to previous tab.
    assert_select "a.active[onclick^='new Ajax.Updater('survey_questions', '/surveys/get_survey_review'][href=#]" 
    assert_select "a.active > img[src^=/images/review.jpg][alt=Review Answers]"

  end
########################################################################################################################################################################  
end
