UPDATE programs 
   SET name = 'Medicaid for Low Income Adults - LIA', 
       description = 'Medicaid program provides medical insurance for very low income adults, ages 19-64, who do not have dependent children and who are not disabled.' 
 WHERE lower(name) LIKE  '%saga medical%';
#------------------------
UPDATE program_links 
   SET link = 'http://www.211ct.org/InformationLibrary/Documents/Medicaid%20cw.asp' 
 WHERE program_id = (SELECT id FROM programs WHERE lower(name) like 'Medicaid for Low Income Adults - LIA');
 