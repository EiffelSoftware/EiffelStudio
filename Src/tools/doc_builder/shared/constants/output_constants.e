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
			Result.extend (studio_lin_flag, studio_lin_desc)
			Result.extend (studio_mac_flag, studio_mac_desc)
			Result.extend (unfiltered_flag, unfiltered)
		end
		
	file_generation_types: ARRAYED_LIST [STRING] is
			-- Valid file generation options
		once
			create Result.make (3)
			Result.compare_objects
			Result.extend (xml_to_help_flag)
			Result.extend (html_to_help_flag)
			Result.extend (xml_to_html_flag)
		end
		
	help_generation_types: ARRAYED_LIST [STRING] is
			-- Valid help generation options
		once
			create Result.make (3)
			Result.compare_objects
			Result.extend (web_help_flag)
			Result.extend (mshtml_help_flag)
			Result.extend (vsip_help_flag)
		end	
		
feature -- Help Tags
	
	mshtml_help_flag: STRING is "mshtml"

	vsip_help_flag: STRING is "vsip"

	web_help_flag: STRING is "web"

	xml_to_html_flag: STRING is "xml2html"
	
	html_to_help_flag: STRING is "html2help"
	
	xml_to_help_flag: STRING is "xml2help"	
		
feature -- Filter tags
		
	unfiltered_flag: STRING is "all"	
		
	studio_flag: STRING is "studio"
	
	studio_win_flag: STRING is "studio_win"
	
	studio_lin_flag: STRING is "studio_lin"
	
	studio_mac_flag: STRING is "studio_mac"
	
	envision_flag: STRING is "envision"

feature -- Filter Descriptions

	none_desc: STRING is "Excluded"

	unfiltered: STRING is "Unfiltered"
	
	studio_desc: STRING is "EiffelStudio"
	
	studio_win_desc: STRING is "EiffelStudio for Windows"
	
	studio_lin_desc: STRING is "EiffelStudio for Unix/Linux"
	
	studio_mac_desc: STRING is "EiffelStudio for Mac OS X"
	
	envision_desc: STRING is "ENViSioN!"

end -- class OUTPUT_CONSTANTS
