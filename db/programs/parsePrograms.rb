index = -1
insert_stmt = "";
name = ""
File.open(File.dirname(__FILE__) + "/programs_info.txt").each do |line|
  if line.include? "name"
    index = index + 1
    #puts "Index: #{index} Program: #{line.gsub( "name: ", "")}"
    name = line.gsub( "name: ", "").strip 
    #insert_stmt = "INSERT INTO program_links (program_id, name, link) (SELECT id, '"
#  elsif line.include? "description: "
#    #puts "Index: #{index} Description: #{line.gsub( "description: ", "")}"
#    insert_stmt += "#{line.gsub( "description: ", "").gsub("'", "''").strip}');"
#    puts insert_stmt
#    insert_stmt = ""
  elsif line.include? "http://"
    links = line.split( ": ")
    insert_stmt = "INSERT INTO program_links (program_id, name, link) SELECT id, '"
    if links[0].include? "application"
      insert_stmt += "an application"
    else
      insert_stmt += "more information"
    end
    insert_stmt += "','#{links[1].strip}' FROM programs WHERE name = '#{name}';"
    puts insert_stmt
  end
end