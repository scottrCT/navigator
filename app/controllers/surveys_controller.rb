class SurveysController < ApplicationController

###############################################################################################################################################
# Description : Processes and creates data for 211 Navigator's home page.
###############################################################################################################################################
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @surveys }
    end
  end
###############################################################################################################################################
# Description : Saves the survey object to the database.
############################################################################################################################################### 
  def create
    #if the from is submitted and the params object is not nil then save the survey object to database
    if request.post? and params[:survey]
      @survey = Survey.new(params[:survey])
      
      @programs = @survey.find_eligible_programs
      
      @survey.ip_addr = request.remote_ip
      
      if @survey.save
        render :partial => 'survey_results', :locals => {:survey => @survey, :programs=>@programs}  
      else
        flash[:surveyerrors] = @survey.errors.full_messages
        render :action => "start_new_survey"
      end
    end
  end
###############################################################################################################################################
# Description : Initializes the Benefits Survey.
###############################################################################################################################################
  def start_new_survey
    logger.debug 'In start_new_survey'
    @survey = Survey.new
    @res_status = Residency.find(:all, :order => "id")
    @dropdown_options = SelectOption.find(:all, :order => "id")
  end
###############################################################################################################################################
# Description : Displays the answers given by the user to the survey questions.
###############################################################################################################################################
  def get_survey_review
    @survey = Survey.new(params[:survey])
    #logger.debug "Net Income: #{@survey.net_income_amt}"
    @survey.net_income_amt = @survey.net_income_amt.to_s.gsub(/[^0-9\.]/,'')
    #logger.debug "Net Income: #{@survey.net_income_amt.to_s}"
    
    render :update do |page|
      activate_tab(page, 'survey_review', 'review_response_container')
    end
  end
###############################################################################################################################################  
# Description : Processes and displays partial for providing personal details about the person who is taking the survey.
###############################################################################################################################################  
  def get_self_details
    logger.debug 'In get_self_details'
    @survey = Survey.new(params[:survey])
    @res_status = Residency.find(:all, :order => "id")
    @dropdown_options = SelectOption.find(:all, :order => "id")
    
    render :update do |page|
      activate_tab(page, 'get_self_details', 'self_info_container')
    end
  end
###############################################################################################################################################
# Description : Processes and displays the partial for providing financial details.
###############################################################################################################################################  
  def get_financial_details
    @survey = Survey.new(params[:survey])
    @tax_filing_method = TaxFilingMethod.find(:all, :order => "id")
    @income_frequency = IncomeFrequency.find(:all, :order => "id")
    @dropdown_options = SelectOption.find(:all, :order => "list_option")
    
    logger.debug "Currently employed: #{@survey.currently_employed}"
    
    render :update do |page|
      activate_tab(page, 'get_finanancial_details', 'financial_info_container')
      
      # Initially hide the personal net income question. Show this question only when the user specifies that
      # he/she is employed.
      page[:personal_net_income].hide if @survey.currently_employed == "" or @survey.currently_employed.nil? or @survey.currently_employed.to_i == 0

      # Initially hide the personal approved training activity question. Show this question only when the user 
      # specifies that he/she is not employed.
      page[:self_training_activity].hide if @survey.currently_employed == "" or @survey.currently_employed.nil? or @survey.currently_employed.to_i == 1
      
      if @survey.have_a_spouse.to_i == 1
        # Initially hide the spouse net income question. Show this question only when the user specifies that
        # his/her spouse is employed.
        page[:spouse_net_income].hide if @survey.spouse_currently_employed == "" or @survey.spouse_currently_employed.nil? or @survey.spouse_currently_employed.to_i == 0
  
        # Initially hide the spouse approved training activity question. Show this question only when the user 
        # specifies that his/her spouse is not employed.
        page[:spouse_training_activity].hide if @survey.spouse_currently_employed == "" or @survey.spouse_currently_employed.nil? or @survey.spouse_currently_employed.to_i == 1
      end
      # Initially hide the other net income question. Show this question only when the user specifies that
      # he/she has other sources of income employed.
      page[:other_net_income].hide if @survey.other_income.nil? or @survey.other_income.to_i != 1 
      
      logger.debug "Net Income Frequency:  #{@survey.net_income_frequency}.  Class:  #{@survey.net_income_frequency.class}"
      @income_frequency.each do |incfreq|
        logger.debug "Value: #{incfreq.annual_multiplier} Class: #{incfreq.annual_multiplier.class} String: #{incfreq.annual_multiplier.to_s}"
      end
    end
  end
###############################################################################################################################################
# Description : Processes and displays partial for providing family details.
###############################################################################################################################################
  def get_family_details
    @survey = Survey.new(params[:survey])
    @dropdown_options = SelectOption.find(:all, :order => "list_option")
    
    render :update do |page|
      activate_tab(page, 'get_family_details', 'family_info_container')
      
      # Initially hide the questions for childeren_13 and children_5. Show these questions only when the 
      # the users specifies that they have children.
      page[:children_under_5].hide if @survey.children_under_18.nil? or @survey.children_under_18.to_i == 0
      page[:children_under_13].hide if @survey.children_under_18.nil? or @survey.children_under_18.to_i == 0 or @survey.children_under_5.to_i == 1
      
    end
  end
###############################################################################################################################################
# Description : Hides and dispalys the children_under_5 div based on the value of children_under_18 column.
###############################################################################################################################################
  def display_children_under_5_div
    @survey = Survey.new(params[:survey])
    @children = params[:survey_children_under_18]
    
    if @children.to_i > 0 and !@children.blank?
      apply_visual_effect(['children_under_5'], true)
    else
      apply_visual_effect(['children_under_5'], false)
    end
  end
###############################################################################################################################################
# Description : Hides and dispalys the children_under_13 div based on the value of children_under_5 column.
###############################################################################################################################################  
  def display_children_under_13_div
    @survey = Survey.new(params[:survey])
    @children = params[:survey_children_under_5]
    
    if @children.to_i == 0
      apply_visual_effect(['children_under_13'], true)
    else
      apply_visual_effect(['children_under_13'], false)
    end
  end
###############################################################################################################################################
# Description : Hides and dispalys the personal_net_income, self_training_activity divs based on the value of currently_employed column.
###############################################################################################################################################  
  def display_net_income_training_div
    @survey = Survey.new(params[:survey])
    @employed = params[:survey_currently_employed]

    if @employed.blank?
      apply_visual_effect(['personal_net_income','self_training_activity'], false)
    elsif @employed.to_i == 1
      apply_visual_effect(['personal_net_income'], true, 'self_training_activity')
    elsif @employed.to_i == 0
      apply_visual_effect(['self_training_activity'], true, 'personal_net_income')
    else
      apply_visual_effect(['personal_net_income','self_training_activity'], false)
    end       
  end
###############################################################################################################################################
# Description : Hides and dispalys the spouse_net_income, spouse_training_activity divs based on the value of spouse_currently_employed column.
###############################################################################################################################################
  def display_spouse_net_income_training_div
    @survey = Survey.new(params[:survey])
    @spouse_employed = params[:survey_spouse_currently_employed]

    if @spouse_employed.blank?
      apply_visual_effect(['spouse_net_income','spouse_training_activity'], false)      
    elsif @spouse_employed.to_i == 1
      apply_visual_effect(['spouse_net_income'], true, 'spouse_training_activity')      
    elsif @spouse_employed.to_i == 0
      apply_visual_effect(['spouse_training_activity'], true, 'spouse_net_income')      
    else
      apply_visual_effect(['spouse_net_income','spouse_training_activity'], false)      
    end        
  end
###############################################################################################################################################
# Description : Hides and dispalys the other_net_income div based on the value of other_income column.  
###############################################################################################################################################
  def display_other_net_income_div
    @survey = Survey.new(params[:survey])
    @oth_income = params[:survey_other_income]
    
    logger.debug 'Here'
    
    if @oth_income.to_i == 1
      apply_visual_effect(['other_net_income'], true)            
    else
      apply_visual_effect(['other_net_income'], false)            
    end
  end
 
###############################################################################################################################################
# Description : Applys visual effects to page elements.
###############################################################################################################################################  
  def alert_user
    @CT_resident = params[:survey_resident_of_CT]
    
    render :update do |page|
      page.alert "The 2-1-1 Navigator is designed for use by Connecticut residents. To find the 2-1-1 that serves your area and to learn about benefits in your area visit http://www.211.org"  if @CT_resident == "0"
    end
    
  end

###############################################################################################################################################
# Description : Displays help about the survey questions within a popup window.
###############################################################################################################################################  
  def help
    render :layout => false
  end
  
end # End class SurveysController

###############################################################################################################################################
# Description : Activates a tab by setting HTML attributes.
###############################################################################################################################################  
  def activate_tab(page, partial_name, container_name)
      page[:survey_tabnav_content].replace_html :partial => partial_name, :locals => {:survey => @survey}
      
      case container_name 
        when 'self_info_container'
         page[:self_info_container].addClassName('active')
         page[:self_info].addClassName('active')
         page[:family_info_container].removeClassName('active') 
         page[:family_info].removeClassName('active') 
         page[:financial_info_container].removeClassName('active') 
         page[:financial_info].removeClassName('active')
         page[:review_response_container].removeClassName('active')      
         page[:review_response].removeClassName('active')
        when 'family_info_container'
         page[:self_info_container].removeClassName('active')
         page[:self_info].removeClassName('active')
         page[:family_info_container].addClassName('active') 
         page[:family_info].addClassName('active') 
         page[:financial_info_container].removeClassName('active') 
         page[:financial_info].removeClassName('active')
         page[:review_response_container].removeClassName('active')      
         page[:review_response].removeClassName('active')       
       when 'financial_info_container'
         page[:self_info_container].removeClassName('active')
         page[:self_info].removeClassName('active')
         page[:family_info_container].removeClassName('active') 
         page[:family_info].removeClassName('active') 
         page[:financial_info_container].addClassName('active') 
         page[:financial_info].addClassName('active')
         page[:review_response_container].removeClassName('active')      
         page[:review_response].removeClassName('active')         
       when 'review_response_container'    
         page[:self_info_container].removeClassName('active')
         page[:self_info].removeClassName('active')
         page[:family_info_container].removeClassName('active') 
         page[:family_info].removeClassName('active') 
         page[:financial_info_container].removeClassName('active') 
         page[:financial_info].removeClassName('active')
         page[:review_response_container].addClassName('active')      
         page[:review_response].addClassName('active')       
       end
  end
###############################################################################################################################################
# Description : Applys visual effects to page elements.
###############################################################################################################################################  
  def apply_visual_effect(page_elements, show, hide_div ='')
    render :update do |page|
      if hide_div != ''
        page[hide_div].hide
      end
      page_elements.each do |element|
        if show == true
          page.visual_effect :appear, element           
          page.visual_effect :highlight, element 
        else
          page.visual_effect :blind_up, element
        end    
      end
    end
  end
