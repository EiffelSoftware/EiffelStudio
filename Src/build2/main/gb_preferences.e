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
			
feature -- Basic operations

	initialize_preferences is
			--
		do
			register_basic_graphical_types
			initialize ("D:\Eiffel54\build\spec\windows\default.xml", Eiffel_preferences)
			Pixmaps_path_cell.put ("D:\Eiffel54\studio\bitmaps\ico")
			Pixmaps_extension_cell.put ("ico")
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
			--

invariant
	invariant_clause: True -- Your invariant here

end -- class GB_RESOURCES
