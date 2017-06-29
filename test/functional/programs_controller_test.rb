require 'test/test_helper'

class ProgramsControllerTest < ActionController::TestCase
  fixtures :programs, :program_links
  
  # Test index page.
  test "programs_index_page" do
    get :index
    
    assert_response :success
    assert_template "index"
    
    # Verify page title.
    assert_select "title", "211 Navigator - United Way of Connecticut"
    
    # Verify that there are 3 image tags in index page.
    assert_select "img", 3
    
    # Index page contains no forms.
    assert_select "form", false, "This page must contain no forms"
    
    # Verify that all the contents are rendered within tab.
    assert_select "body > div#main_tabnav ~ div#main_tabnav_content"
    
    # verify the page header.
    assert_select "h1[class=header]", "Programs Overview"
    assert_select "h2[class=subheader]", "Click on the program's name for its description, links to more information, and, when available, an electronic application."
    
    # Verify that the footer is rendered at the end and also the DOM.
    assert_select "body > div#header ~ div#main_tabnav ~ div#main_tabnav_content ~ div#footer"    
  end  
########################################################################################################################################################################  
  # Test the navigation links on programs index page.
  test "programs_navigation_links" do
    get :index

    assert_response :success
    assert_template "index"
    
    # Verify navigation links.
    assert_select "div#main_tabnav > ul > li" do
      assert_select "li[class='']" do 
        assert_select "a[class=''][title=Home][href=/]", "Home" 
      end
      assert_select "li[class*=active]" do # Verify "Programs" tab is selected for Program controller index action by inspecting class attribute.
        assert_select "a[class*=active][title=Programs][href=/programs]", "Programs" # Verify "Programs" tab is selected for Program controller index action by inspecting class attribute.
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
  # Test All the program links.
  test "available_programs_links" do
    get :index

    assert_response :success
    assert_template "index"
    
    # Test programs links.
    assert_select "div#programsListed > ul > li" do
      Program.find(:all).each do |prog| 
        assert_select "a[class=programName][onclick=javascript:$('#{prog.id.to_s}').toggle()][href=#]", prog.name
      end
    end
    
    # Test program description and links for "More Info" and "Application (if available)" for each program.
    assert_select "div#programsListed > ul > li" do
      Program.find(:all).each do |prog| 
        assert_select "div[id=#{prog.id.to_s}]" do
          assert_select "span.programDesc", prog.description.to_s
          ProgramLink.find(:all, :conditions => ["program_id = ?", prog.id]).each do |plink|     
            assert_select "span.programLink" do
              assert_select "a[target=_blank][href=#{plink.link}]", "Click for #{plink.name}"                        
            end
          end
        end
      end
    end
    
  end
########################################################################################################################################################################
end
