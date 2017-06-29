class Survey < ActiveRecord::Base
  belongs_to :residency
  belongs_to :tax_filing_method
  belongs_to :selection_option
  
  validates_presence_of :age, 
                        :children_under_18, 
                        :adult_dependants, 
                        :currently_employed
                        
  validates_numericality_of :age, :only_integer => true, :message => "can only be whole number."                        
  validates_numericality_of :children_under_18, :only_integer => true, :message => "can only be whole number." 
  validates_numericality_of :adult_dependants, :only_integer => true, :message => "can only be whole number." 
  validates_inclusion_of :age, :in => 0..125, :message => "can only between 0 and 125"
  
###############################################################################################################################################
# Description : Determines and retuns all the progrmas the user is eligible for.
###############################################################################################################################################  
  def find_eligible_programs
    fpl
      
    smi
      
    @fpl_income_pct = annualFamilyIncome(true)/@fpl_lvl
      
    @smi_income_pct = annualFamilyIncome(true)/@smi_lvl
      
    logger.debug "FPL % = #{@fpl_income_pct}"
      
    logger.debug "SMI % = #{@smi_income_pct}"
      
    #logger.debug "Family Income is = #{@familyIncome/@fpl_lvl*100}% FPL"

    #Making annualFamilyIncome not include the other income because EITC is calculated using the annual_income_max field and that
    #does not include other income. The other programs that may be erroneously included because of not including that field
    #will be excluded when doing the detailed screening for that program
    @programs = Program.find(:all, :conditions=>["(fpl_max < 0 AND smi_max < 0 AND annual_income_max < 0) OR (fpl_max > 0 AND fpl_max >= ?) OR (smi_max > 0 AND smi_max >= ?) OR (annual_income_max > 0 AND annual_income_max >= ?)", @fpl_income_pct, @smi_income_pct, annualFamilyIncome(false)], :order=>"name")
      
    logger.debug "Number Programs Returned: #{@programs.size}"
      
    #@programs.each do |program|
      #logger.debug "check_#{program.method_nm}"
      #if 
        @programs.delete_if {|program| !eval "check_#{program.method_nm}"}
      #end
    #end
      
    programsGiven = ""
      
    @programs.each do |program|
      programsGiven << "#{program.id} "
    end
    
    self.programs = programsGiven.strip
   
    @programs
    #self.ip_addr = request.remote_ip
    
  end
###############################################################################################################################################
# Description : Returns true if the user is a resident of CT.
###############################################################################################################################################  
  def ctResident?
    logger.debug "In ctResident?.  Returning #{resident_of_CT == 1}"
    return resident_of_CT == 1
  end
###############################################################################################################################################
# Description : Returns true if the user has child(ren) under 18 years of age.
###############################################################################################################################################  
  def hasChildren?
    logger.debug "In hasChildren?.  Returning #{children_under_18 > 0}"
    return children_under_18 > 0
  end
###############################################################################################################################################
# Description : Calculates and returns the family size.
###############################################################################################################################################  
  def familySize
     if @familySize == nil || @familySize <= 0
        #Family size is calculated as the sum of the answers to:
        #  - yourself (1) + 
        #  - if you have a spouse or not (answer values:  no=0, yes=1)
        #  - the number of children under 18 in the household
        #  - the number of dependent adults
        @familySize = 1 + have_a_spouse + children_under_18 + adult_dependants
        
        if @familySize > 12
          @familySize = 12
        end
     end
     
     logger.debug "In familySize.  #{@familySize}"
     return @familySize
  end
###############################################################################################################################################
# Description : Returns true if the user has child(ren) under 5 years of age.
###############################################################################################################################################  
  def hasChildrenUnder5?
    logger.debug "In hasChildrenUnder5?.  #{children_under_5 != nil && children_under_5 == 1}"
    return children_under_5 != nil && children_under_5 == 1
  end
###############################################################################################################################################
# Description : Returns true if the user has child(ren) under 13 years of age.
###############################################################################################################################################  
  def hasChildrenUnder13?
    logger.debug "In hasChildrenUnder13?.  #{children_under_13 != nil && children_under_13 > 0}"
    return children_under_13 != nil && children_under_13 > 0
  end
###############################################################################################################################################
# Description : Returns true if the user is employed.
###############################################################################################################################################  
  def isEmployed?
    logger.debug "In isEmployed?.  #{currently_employed == 1}"
    return currently_employed == 1
  end
###############################################################################################################################################
# Description : Returns true if the user is under a training activity.
###############################################################################################################################################  
  def isTraining?
    logger.debug "In isTraining?.  #{!isEmployed? && approved_training_activity == 1}"
    return !isEmployed? && approved_training_activity == 1
  end
###############################################################################################################################################
# Description : Returns true if the user has a spouse.
###############################################################################################################################################  
  def hasSpouse?
    logger.debug "In hasSpouse?.  #{have_a_spouse == 1}"
    return have_a_spouse == 1
  end
###############################################################################################################################################
# Description : Returns true if the spouse is employed.
###############################################################################################################################################  
  def isSpouseEmployed?
    logger.debug "In isSpouseEmployed?.  #{hasSpouse? && spouse_currently_employed == 1}"
    return hasSpouse? && spouse_currently_employed == 1
  end
###############################################################################################################################################
# Description : Returns true if the spouse is under a training activity.
###############################################################################################################################################  
  def isSpouseTraining?
    logger.debug "In isSpouseTraining?.  #{!isSpouseEmployed? && spouse_approved_training_activity == 1}"
    return !isSpouseEmployed? && spouse_approved_training_activity == 1
  end
###############################################################################################################################################
# Description : Returns true if the use is filing taxes.
###############################################################################################################################################  
  def isFiling?
    logger.debug "In isFiling?.  #{tax_filing_method_id > 0}"
    return tax_filing_method_id > 0
  end
###############################################################################################################################################
# Description : Returns true if any adult living with the user has any kind of disability.
###############################################################################################################################################  
  def isDisabled?
    logger.debug "In isDisabled?.  #{adult_disability == 1}"
    return adult_disability == 1
  end
###############################################################################################################################################
# Description : Returns true if anyone in the user's household is currently pregnant or was pregnant in last 12 months.
###############################################################################################################################################  
  def isPregnant?
    logger.debug "In isPregnant?.  #{pregnant == 1}"
    return pregnant == 1
  end
###############################################################################################################################################
# Description : Returns true if the user is US Citizen, US Resident or Asylee/Refugee.
###############################################################################################################################################  
  def isUSResident?
    logger.debug "In isUSResident?.  #{residency_id <= 3}"
    return residency_id <= 3
  end
###############################################################################################################################################
# Description : Calculates and returns the annual family income.
###############################################################################################################################################  
  def annualFamilyIncome(includeOther=true)
    if (includeOther && !defined?(@familyIncomeWithOther)) || (!includeOther && !defined?(@familyIncomeWithoutOther))
      logger.debug "Family income not calculated yet for other #{includeOther ? '':'not '}included "
      familyIncome = 0
      
      if currently_employed == 1
        familyIncome += getAnnualEquivalent(net_income_amt, net_income_frequency)
      end
        
      if spouse_currently_employed == 1
        familyIncome += getAnnualEquivalent(spouse_net_income_amt, spouse_net_income_frequency)
      end
        
      if includeOther && other_income == 1
        familyIncome += getAnnualEquivalent(other_income_amt, other_income_frequency)
      end
      
      if includeOther
        @familyIncomeWithOther = familyIncome
      else
        @familyIncomeWithoutOther = familyIncome
      end
    end
    
    logger.debug "Family income: #{includeOther ? @familyIncomeWithOther : @familyIncomeWithoutOther} (Other included? #{includeOther ? 'yes':'no'})"
    
    return includeOther ? @familyIncomeWithOther : @familyIncomeWithoutOther
  end
###############################################################################################################################################
# Description : Calculates and returns annual income.
###############################################################################################################################################  
  def getAnnualEquivalent(income, freq)
    logger.debug "Income: #{income}.  Frequency: #{freq}.  Total: #{income.to_f*freq.to_i}"
    return income.to_f*freq.to_i
  end
  
  def text_income_frequency(freq)
    text = ""
    case freq.to_i
    when 52
      text = "weekly"
    when 26
      text = "biweekly"
    when 24
      text = "twice monthly"
    when 12
      text = "monthly"
    else
      text = "yearly"
    end
    return text
  end
###############################################################################################################################################
# Description : Finds the Federal Poverty Level for a given year.
###############################################################################################################################################  
  def fpl
    year = get_year
    
    fplval = Fpl.find(:first, :conditions=>["year=?", year])
    
    if fplval.blank?
      fplval = Fpl.find(:first, :order=>"year DESC");
    end
    
    logger.debug "FPL value #{fplval.base_amt}; Year = #{fplval.year}"
    
    @fpl_lvl = fplval.base_amt + (fplval.offset*(familySize-1))
  end
###############################################################################################################################################
# Description : Finds the State Median Income for a given year.
###############################################################################################################################################  
  def smi
    year = get_year
    
    smival = Smi.find(:first, :conditions=>["year=? AND family_size=?", year, familySize])
    
    if smival.blank?
      smival = Smi.find(:first, :conditions=>["family_size=?", familySize], :order=>"year DESC");
    end
    
    logger.debug "SMI value #{smival.amt}; year = #{smival.year}"
     
    @smi_lvl = smival.amt
  end
###############################################################################################################################################
# Description : Finds the year that is used to determine FPL and SMI.
###############################################################################################################################################  
  def get_year
    if Time.now().month < 6
      year = Time.now().year - 1
    else
      year = Time.now().year
    end
    return year
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Connecticut Care 4 Kids" program.
###############################################################################################################################################  
  def check_c4k
    logger.debug "In C4K"
#    if self.hoh_state and \
#        self.hoh_children and (self.kwargs.get('has_children_under5') or
#                               self.kwargs.get('has_children_under13')) and \
#        (self.hoh_is_employed or self.kwargs.get('hoh_is_training', False)) and \
#        (not self.hoh_spouse or (self.kwargs.get('spouse_is_employed', 0) or
#                                 self.kwargs.get('spouse_is_training', 0))) and \
#        self._are_children_citizens() and self.income.smi(0.75): 
#            return self._return(True)
#
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'c4k'"])
    logger.debug("#{program.name} - SMI max: #{program.smi_max}.  SMI PCT: #{@smi_income_pct}")
    if ctResident? and hasChildren? and (hasChildrenUnder5? or hasChildrenUnder13?) and (isEmployed? or isTraining?) and (!hasSpouse? or isSpouseEmployed? or isSpouseTraining?) and @smi_income_pct <= program.smi_max
      logger.debug "C4K eligible"
      return true
    end
    logger.debug "Not C4K eligible"
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Earned Income Tax Credit" program.
###############################################################################################################################################  
  def check_eitc
#    """Determines whether the user qualifies for a tax rebate.
#        
#        Per Carol Davis:
#        If the user says she's married, then per EITC rules she will have to
#        file jointly to be considered for this program
#        We will handle it like this:
#        *if the user has a spouse, but answers "single" to the tax question,
#        then we'll ignore the answer and use "jointly" to do the check, and we
#        will put an "infobox" disclaimer on the results page.
#        * if the user says "won't fill", we won't even check.
#        * if the user says single, and doesn't have a spouse, we'll do single.
#        * if the user says jointly and DOESN'T HAVE A SPOUSE, we'll do single.
#        Remember that the spouse question is "got a spouse who LIVES there?"
#        """
#        def dof(i):
#            #the default value is an empty string, which cannot be floated
#            try: return float(i)
#            except: return 0
#        
#        if not self.kwargs.get('filing_status', 0):
#            return self._return(False)
#        
#        #which salary_thisyear are we gonna count?
#        if self.hoh_spouse or self.kwargs.get('filing_status') == 'joint':
#            salary_thisyear = dof(self.kwargs.get('hoh_salary_thisyear')) +\
#                              dof(self.kwargs.get('spouse_salary_thisyear'))
#        else:
#            salary_thisyear = dof(self.kwargs.get('hoh_salary_thisyear'))
#
#        #doing
#        if self.income.eitc(self.hoh_children, salary_thisyear) and \
#        self.hoh_citizenship <= 2 and \
#        (self.kwargs.get('salary_amount') or \
#         self.kwargs.get('spouse_salary_amount') or \
#         dof(self.kwargs.get('hoh_salary_thisyear')) or \
#         dof(self.kwargs.get('spouse_salary_thisyear'))
#        ):
#            
#        #Per Carol, we are not checking on the other income here.
#         #self.kwargs.get('otherincome_amount')):
#            return self._return(True)
#        
#        return self._return(False)

    if !isFiling?
      return false
    end
    
    #For EITC, if they have a spouse, we assume jointly no matter what.  If no spouse, use single
    if hasSpouse?
      filingStatus = 2
    else
      filingStatus = 1
    end
    
    numbChildren = children_under_18 > 3 ? 3 : children_under_18
    
    eitcIncome = annualFamilyIncome(false)
    
    eitc = Eitc.find(:first, :conditions=>["year=? AND filing_status=? AND children_no=?", get_year, filingStatus, numbChildren])
    
    if eitc.blank?
      eitc = Eitc.find(:first, :conditions=>["filing_status=? AND children_no=?", filingStatus, numbChildren], :order=>"year DESC")
    end
    
    logger.debug "EITC value #{eitc.amount}; Year = #{eitc.year}"
    
    if eitc.amount >= eitcIncome and isUSResident? and (isEmployed? or isSpouseEmployed?)
      return true
    end
    
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Food Stamps/SNAP" program.
###############################################################################################################################################  
  def check_snap
#    if self.income.fpl(1.85) and \
#        self.hoh_citizenship <= 3:
#            return self._return(True)
#        
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'snap'"])
# As per SeanG We are removing the USResident criteria for Food Stamps/SNAP program if a person has children since if the person is not a 
# US Citizen or Permanent Resident or Asylee/Refugee and has children then they may be eligible for Food Stamps/Snap because his/her children 
# might be US Citizen or Permanent Resident or Asylee/Refugee. This is a temporary fix until we add the question specifically asking for 
# children citizenship.
#    if isUSResident? and @fpl_income_pct <= program.fpl_max
    if hasChildren?
      if @fpl_income_pct <= program.fpl_max
        return true
      end
    else 
      if isUSResident? and @fpl_income_pct <= program.fpl_max
        return true
      end
    end 
    
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "SAGA Cash" program.
###############################################################################################################################################  
  def check_sagacash
#    if self.hoh_age >= 18 and self.hoh_citizenship <= 2 and \
#        self.income.monthly() <= 207:
#            return self._return(True)
#        
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'sagacash'"])
    if age >= 18 and isUSResident? and ctResident? and annualFamilyIncome(true) <= program.annual_income_max
      return true
    end
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "SAGA Medical" program.
###############################################################################################################################################  
  def check_sagamed
#    #Carol Davis, 01.17.2007:
#        #Medicaid and for SAGA Medical. If they are elig for HUSKY A for
#        #Parents, they do not need either of these. (they are already covered
#        #for health insurance)
#        
#        if self.huskya_parents()[0]:
#            return self._return(False)
#        
#        if self.hoh_age >= 18 and self.hoh_age <= 64 and \
#        self.hoh_citizenship <= 2 and self.income.fpl(1):
#            return self._return(True)
#        
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'sagamed'"])
    if !check_huskya_parents and age >= 18 and age <= 64 and isUSResident? and ctResident? and @fpl_income_pct <= program.fpl_max
      return true
    end
    
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Husky A: For Children" program.  
###############################################################################################################################################  
  def check_huskya_children
#    if self.hoh_children and self.income.fpl(1.85) and \
#        self._are_children_citizens():
#            return self._return(True)
#        
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'huskya_children'"])
    if hasChildren? and ctResident? and @fpl_income_pct <= program.fpl_max
      return true
    end

    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Husky A: For Parents/Caregiver Relatives" program. 
###############################################################################################################################################  
  def check_huskya_parents
#    #Dad cannot be on Husky if the kids are not in Husky.
#        if not self.huskya_children()[0]:
#            return self._return(False)
#        
#        if self.hoh_citizenship <= 2 and self.income.fpl(1.85):
#            return self._return(True)
#        
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'huskya_parents'"])
    if check_huskya_children and isUSResident? and ctResident? and @fpl_income_pct <= program.fpl_max
      return true
    end
      
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Husky B: For Children" program. 
###############################################################################################################################################    
  def check_huskyb
#    if self.hoh_children and not self.huskya_children()[0] and \
#        self._are_children_citizens():
#            return self._return(True)
#        
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'huskyb'"])
    if hasChildren? and ctResident? and !check_huskya_children
      return true
    end 
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Medicaid" program.
###############################################################################################################################################  
  def check_medicaid
#    #Carol Davis, 01.17.2007:
#        #Medicaid and for SAGA Medical. If they are elig for HUSKY A for
#        #Parents, they do not need either of these. (they are already covered
#        #for health insurance)
#        
#        if self.huskya_parents()[0]:
#            return self._return(False)
#        
#        if (self.hoh_age >= 65 or self.is_disabled) and \
#        self.hoh_citizenship <= 2 and self.income.fpl(1):
#            return self._return(True)
#        
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'medicaid'"])
    if !check_huskya_parents and (age >= 65 or isDisabled?) and isUSResident? and @fpl_income_pct <= program.fpl_max
      return true
    end
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Medicaid for the Employed Disabled" program.
###############################################################################################################################################  
  def check_medicaid_emp_disabled
#    #04.09.2007: Per Carol Davis, either the HoH or the Spouse employed
#        if self.hoh_age >= 18 and self.is_disabled and \
#        self.hoh_citizenship <= 2 and self.income.annual() <= 75000 and \
#        (self.hoh_is_employed or self.kwargs.get('spouse_is_employed')):
#            return self._return(True)
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'medicaid_emp_disabled'"])
    if age >= 18 and isDisabled? and isUSResident? and ctResident? and annualFamilyIncome(true) <= program.annual_income_max and (isEmployed? or (hasSpouse? and isSpouseEmployed?))
      return true
    end
    
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Medicare" program.
###############################################################################################################################################  
  def check_medicare
#    if (self.hoh_age >= 65 or self.is_disabled) and \
#        self.hoh_citizenship <= 2:
#            return self._return(True)
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'medicare'"])
    if (age >= 65 or isDisabled?) and isUSResident?
      return true  
    end
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Medicare D" program.
###############################################################################################################################################  
  def check_medicared
#    if self.medicare_ab()[0]:
#            return self._return(True)
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'medicared'"])
    return check_medicare
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Medicare D Low Income Subsidy" program.
###############################################################################################################################################  
  def check_medicared_low_income
#    if self.medicare_ab()[0] and self.income.fpl(1.5):
#            return self._return(True)
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'medicared_low_income'"])
    if check_medicare and @fpl_income_pct <= program.fpl_max
       return true  
    end
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "ConnPACE" program.
###############################################################################################################################################  
  def check_connpace
#    _income = self.hoh_spouse and 33800 or 25100
#        
#        if (self.hoh_age >= 65 or self.is_disabled) and \
#        self.hoh_citizenship <= 2 and self.income.annual() <= _income:
#            return self._return(True)
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'connpace'"])
    connpace_limit = program.annual_income_max
    if !hasSpouse?
      connpace_limit = 26000.0 #25100.0
    end
    
    #logger.debug "ConnPace limit: #{connpace_limit} Class: #{connpace_limit.class} AFI class: #{annualFamilyIncome(true).class}"
    if (age >= 65 or isDisabled?) and isUSResident? and ctResident? and annualFamilyIncome(true) <= connpace_limit
      return true
    end
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Rent Rebate" program.  
###############################################################################################################################################   
  def check_rent_rebate
#    _income = self.hoh_spouse and 37300 or 30500
#        
#        if (self.hoh_age >= 65 or self.is_disabled) and \
#        self.hoh_state and self.hoh_citizenship <= 2 and \
#        self.income.annual() <= _income:
#            return self._return(True)
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'rent_rebate'"])    
    rent_rebate_limit = program.annual_income_max
    if !hasSpouse?
      rent_rebate_limit = 33500.0 #32300
    end
    
    if (age >= 65 or isDisabled?) and ctResident? and isUSResident? and annualFamilyIncome(true) <= rent_rebate_limit
      return true
    end
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Social Security Disability - SSD" program.  
###############################################################################################################################################   
  def check_ssd
#    if self.hoh_age >= 18 and self.hoh_age <= 64 and \
#        self.hoh_citizenship <= 2 and self.is_disabled:
#            return self._return(True)
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'ssd'"])
    
    if age >= 18 and age <= 64 and isUSResident? and isDisabled?
      return true
    end
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Supplemental Security Income - SSI" program.  
###############################################################################################################################################   
  def check_ssi
#    #04.09.2007: added income limits per Carol Davis
#        _income = self.hoh_spouse and 930 or 600
#        
#        if (self.hoh_age >= 65 or self.is_disabled) and \
#        self.hoh_citizenship <= 2 and self.income.monthly() <= _income:
#            return self._return(True)
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'ssi'"])
    ssi_income_limit = program.annual_income_max
    if hasSpouse?
      ssi_income_limit = 600*12
    end
    
    if (age >= 65 or isDisabled?) and isUSResident? and isDisabled? and annualFamilyIncome(true) <= ssi_income_limit
      return true
    end
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "WIC" program.  
###############################################################################################################################################   
  def check_wic
#    if (self.is_pregnant or
#           (self.hoh_children and self.kwargs.get('has_children_under5'))) and \
#        self.income.fpl(1.85):
#            return self._return(True)
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'wic'"])
    
    if (isPregnant? or (hasChildren? and hasChildrenUnder5?)) and @fpl_income_pct <= program.fpl_max
      return true
    end
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Utility Assistance - CEAP - CHAP" program.
###############################################################################################################################################   
  def check_chap
#    #CEAP and CHAP checks.
#        #04.09.2007, per Carol Davis, we will only check for the following:
#        
#        if self.hoh_state and self.income.smi(0.6):
#            return self._return(True)
#        
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'chap'"])
    
    if isUSResident? and ctResident? and @smi_income_pct <= program.smi_max
      return true
    end
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Temporary Family Assistance - TFA" program.
###############################################################################################################################################   
  def check_tfa
#    if self.hoh_citizenship <= 2 and self.hoh_children > 0 and \
#        self.income.fpl(1):
#            return self._return(True)
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'tfa'"])
    if hasChildren? and isUSResident? and @fpl_income_pct <= program.fpl_max
      return true
    end
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Operation Fuel" program.
###############################################################################################################################################  
  def check_opfuel
#    #between 1.5 and 2 of the FPL
#        if self.income.fpl(2, minimum = 1.5):
#            return self._return(True)
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'opfuel'"])
    if ctResident? and @fpl_income_pct <= program.fpl_max #This has been changed by Sean Ghio/Carol Davis - @fpl_income_pct.between?(1.5, program.fpl_max)
      return true
    end
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "School Breakfast-School Lunch Program" program.
###############################################################################################################################################   
  def check_school_lunch
#    if self.hoh_children and self.income.fpl(1.85):
#            return self._return(True)
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'school_lunch'"])
    if hasChildren? and @fpl_income_pct <= program.fpl_max
      return true
    end
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Healthy Start" program.
###############################################################################################################################################   
  def check_healthy_start
#    if self.huskya_children()[0]:
#            return self._return(False)
#        
#        if self.is_pregnant and self.hoh_citizenship <= 2 and \
#        self.income.fpl(2.50):
#            return self._return(True)
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'healthy_start'"])
    if !check_huskya_children and isPregnant? and isUSResident? and ctResident? and @fpl_income_pct <= program.fpl_max
      return true
    end
    return false
  end
###############################################################################################################################################
# Description : Checks if the user is eligible for "Medicare Savings Programs - QMB - SLMB - ALMB" program.
###############################################################################################################################################   
  def check_medicare_savings
#    #AKA Medicare QMB/SLMB/ALMB
#        
#        #_income = self.hoh_spouse and 26352 or 17964
#        
#        if self.medicare_ab()[0] and self.income.fpl(2.32):#self.income.annual() <= _income:
#            return self._return(True)
#        return self._return(False)
    program = Program.find(:first, :conditions=>["method_nm = 'medicare_savings'"])
    if check_medicare and @fpl_income_pct <= program.fpl_max
      return true
    end
    return false
  end
  
end
