indexing
	description: "Constants for output filtering"
	date: "$Date$"
	revision: "$Revision$"

class
	OUTPUT_CONSTANTS
	
feature -- Access

	output_list: HASH_TABLE [STRING, STRING] is
			-- List of possible filter output types hashed by description
		once
			create Result.make (3)
			Result.compare_objects
			Result.extend (studio_flag, studio_desc)
			Result.extend (envision_flag, envision_desc)
			Result.extend (unfiltered_flag, unfiltered)
		end
		
	file_generation_types: ARRAYED_LIST [STRING] is
			-- Valid file generation options
		once
			create Result.make (3)
			Result.compare_objects
			Result.extend (Xml_to_help_flag)
			Result.extend (Html_to_help_flag)
			Result.extend (Xml_to_html_flag)
		end
		
	help_generation_types: ARRAYED_LIST [STRING] is
			-- Valid help generation options
		once
			create Result.make (3)
			Result.compare_objects
			Result.extend (Web_help_flag)
			Result.extend (Studio_help_flag)
			Result.extend (Envision_help_flag)
		end	
		
feature -- Flags		

	none: STRING is "none"

	none_desc: STRING is "Excluded"

	unfiltered: STRING is "Unfiltered"
		
	studio_flag: STRING is "studio"
	
	envision_flag: STRING is "envision"
	
	unfiltered_flag: STRING is "all"

	studio_desc: STRING is "EiffelStudio"
	
	envision_desc: STRING is "ENViSioN!"

	studio_help_flag: STRING is "mshtml"

	envision_help_flag: STRING is "vsip"

	web_help_flag: STRING is "web"

	xml_to_html_flag: STRING is "xml2html"
	
	html_to_help_flag: STRING is "html2help"
	
	xml_to_help_flag: STRING is "xml2help"	

end -- class OUTPUT_CONSTANTS
