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
			l_loc: FILE_NAME
		do
			create l_loc.make_from_string (shared_constants.application_constants.templates_path)
			l_loc.extend ("default.xml")
			debug ("trace")
				print ("default file: " + l_loc.string + "%N")
				print ("registry location: HKEY_CURRENT_USER\EiffelDoc%N")
			end			
			create preferences.make_with_default_values_and_location (l_loc.string, "HKEY_CURRENT_USER\EiffelDoc")
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
			window: PREFERENCES_GRID_WINDOW
		do
			create window.make (preferences, application_window)
			window.show
		end		

end
