indexing
	description: "Objects that provide access to the EiffelBuild resources."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PREFERENCES
	
inherit
	RESOURCES_STRING_CONSTANTS
	
	SHARED_RESOURCES
	
	EIFFEL_ENV

feature -- Access

	build_window__height: STRING is "build_window__height"
	
	build_window__width: STRING is "build_window__width"
	
	build_window__x_position: STRING is "build_window__x_position"
	
	build_window__y_position: STRING is "build_window__y_position"
	
	main_split__position: STRING is "main_split__position"
	
	tool_order: STRING is "tool_order"
	
	external_tool_order: STRING is "external_tool_order"
			
feature -- Basic operations

	initialize_preferences is
			-- Initialize preferences.
		local
			directory: DIRECTORY_NAME
			file_name: FILE_NAME
		do
			register_basic_graphical_types
			create file_name.make_from_string (Eiffel_installation_dir_name)
			file_name.extend ("build")
			file_name.extend ("config")
			file_name.extend ("default.xml")
			initialize (file_name, Eiffel_preferences)
			directory := Bitmaps_path
			if eiffel_platform.as_lower.is_equal ("windows") then
				Pixmaps_path_cell.put (directory)
				Pixmaps_extension_cell.put ("ico")
			else
				Pixmaps_path_cell.put (directory)
				Pixmaps_extension_cell.put ("png")
			end
		end

	show_preference_window is
			-- Ensure that `preference_window' is displayed.
		do
			create preference_window.make
			preference_window.show
		end
		
feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	preference_window: PREFERENCE_WINDOW
			-- Preference window used to allow editing of the preferences.

invariant
	invariant_clause: True -- Your invariant here

end -- class GB_RESOURCES
