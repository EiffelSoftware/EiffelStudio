indexing
	description: "String constants that appear in the code of the preference library"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCES_STRING_CONSTANTS

feature -- Access: Preference window string constants

	t_Preference_window: STRING is	"Preferences"
			-- Title of the preference window.

	l_Short_name: STRING is			"Short name"
	l_Literal_value: STRING is		"Literal Value"
			-- Titles of the columns in the preference window.
			
	l_Do_not_show_again: STRING is	"Do not show again"
	w_Preferences_delayed_resources: STRING is
		once
			Result := "The changes you have made to the following resources%Nwill be taken into account after you restart.%N%N"
		end
			-- Texts used in the dialog that tells the user
			-- they have to restart the application to use the new preferences.

	b_Close: STRING is 				"Close"
	b_Restore_defaults: STRING is	"Restore Defaults"
			-- Texts on the button in the preference window.

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

end -- class RESOURCES_STRING_CONSTANTS
