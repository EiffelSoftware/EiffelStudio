indexing
	description: "Objects that provide access to constants loaded from files."
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
	default_value: STRING is		"default"
	user_value: STRING is			"user set"
	auto_value: STRING is		"auto"
	no_description_text: STRING is	"No description available for this preference."

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

	preference_window_icon: STRING is "icon_preference_window"
		-- Base name of the file that contains the icon of the preferences window.
	
end -- class CONSTANTS
