indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_PREFERENCES
	
inherit
	SHARED_OBJECTS

feature -- Access

	initialize is
			-- 
		local
			l_loc, l_prefname: FILE_NAME
		do
			create l_loc.make_from_string (shared_constants.application_constants.templates_path)
			l_loc.extend ("default.xml")
			if (create {PLATFORM}).is_windows then
				create preferences.make_with_defaults_and_location (<<l_loc.string>>, "HKEY_CURRENT_USER\Software\ISE\doc_builder")
			else
				create l_prefname.make_from_string ((create {EXECUTION_ENVIRONMENT}).home_directory_name)
				l_prefname.set_file_name (".doc_builder")
				create preferences.make_with_defaults_and_location (<<l_loc.string>>, l_prefname)
			end
			create editor_data.make (preferences)
			create tool_data.make (preferences)
		end		
	
	editor_data: EDITOR_DATA	
		
	tool_data: TOOL_DATA

	preferences: PREFERENCES
		
feature -- Commands		
		
	show_preferences_window (a_window: EV_WINDOW) is
			-- 
		local
			window: PREFERENCES_WINDOW
		do
			create window.make (preferences, application_window)
			window.show
		end		

end
