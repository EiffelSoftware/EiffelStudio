indexing
	description: "Objects that provide access to constants loaded from files."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCE_CONSTANTS

inherit
	PREFERENCE_CONSTANTS_IMP

feature -- Access

	l_name: STRING is				"Name"	
	l_literal_value: STRING is		"Literal Value"
	l_status: STRING is				"Status"
	l_type: STRING is				"Type"
	p_default_value: STRING is		"default"
	user_value: STRING is			"user set"
	auto_value: STRING is		"auto"
	no_description_text: STRING is	"No description available for this preference."
	preferences_title: STRING is "Preferences"
	restore_preference_string: STRING is "This will reset ALL preferences to their default values%N and all previous settings will be overwritten.  Are you sure?"	
	
	Alt_text: STRING is "Alt"	
	Ctrl_text: STRING is "Ctrl"	
	Shift_text: STRING is "Shift"
	Shortcut_delimiter: STRING is "+"

	w_Preferences_delayed_resources: STRING is
			-- Texts used in the dialog that tells the user
			-- they have to restart the application to use the new preferences.
		once
			Result := "The changes you have made to the following resources%Nwill be taken into account after you restart.%N%N"
		end			

	Pixmaps_path_cell: CELL [STRING] is
			-- Path where pixmaps for the preference window should be looked for.
			-- By default it looks in pixmaps in the current directory, but
			-- it is possible to change the contents of this cell to change this path.
		once
			create Result.put ("pixmaps")
		end

	Pixmaps_extension_cell: CELL [STRING] is
			-- Extension for pixmaps.
		once
			create Result.put ("png")
		end

	preference_window_icon: STRING is "icon_preference_window";
		-- Base name of the file that contains the icon of the preferences window.
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class CONSTANTS
