note
	description: "Objects that provide access to constants loaded from files."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCE_CONSTANTS

feature -- Access

	l_name: STRING_32				do Result := "Name" end
	l_literal_value: STRING_32		do Result := "Literal Value" end
	l_status: STRING_32				do Result := "Status" end
	l_type: STRING_32				do Result := "Type" end
	l_request_restart: STRING_32	do Result := " (REQUIRES RESTART)" end
	l_tree_view: STRING_32			do Result := "Tree View" end
	f_switch_to_tree_view: STRING_32 do Result := "Switch to Tree View" end
	l_flat_view: STRING_32			do Result := "Flat View" end
	f_switch_to_flat_view: STRING_32 do Result := "Switch to Flat View" end

	l_matches_of_total_preferences (a_count, a_total_count: READABLE_STRING_GENERAL): STRING_32
		require
			a_count_not_void: a_count /= Void
			a_total_count_not_void: a_total_count /= Void
		do
			create Result.make (50)
			Result.append_string_general (a_count)
			Result.append_string_general (" matches of ")
			Result.append_string_general (a_total_count)
			Result.append_string_general (" total preferences")
		end

	l_count_preferences (a_count: READABLE_STRING_GENERAL): STRING_32
		require
			a_count_not_void: a_count /= Void
		do
			Result := a_count.as_string_32 + " preferences"
		end

	l_updating_the_view: STRING_32 	do Result := "Updating the view ..." end
	l_filter: STRING_32				do Result := "Filter:" end
	l_tree_or_flat_view: STRING_32		do Result := "Tree/Flat View" end
	l_restore_defaults: STRING_32 		do Result := "Restore Defaults" end
	l_restore_default: STRING_32		do Result := "Restore Default" end
	l_no_default_value: STRING_32 		do Result := "No default value" end
	l_close: STRING_32					do Result := "Close" end
	l_display_window: STRING_32 		do Result := "Display window" end
	l_description: STRING_32			do Result := "Description" end
	l_building_flat_view: STRING_32	do Result := "Building flat view ..." end
	l_building_tree_view: STRING_32	do Result := "Building tree view ..." end


	p_default_value: STRING_32		do Result := "default" end
	user_value: STRING_32			do Result := "user set" end
	auto_value: STRING_32			do Result := "auto" end
	no_description_text: STRING_32	do Result := "No description available for this preference." end
	preferences_title: STRING_32 	do Result := "Preferences" end
	restore_preference_string: STRING_32 do Result := "This will reset ALL preferences to their default values%N and all previous settings will be overwritten.  Are you sure?" end
	shortcut_modification_denied: STRING_32 do Result := "Shortcut modification failed. It is either used by a fixed shortcut or reserved by the system." end
	preferences_root: STRING_32 do Result := "Preferences root" end

	Alt_text: STRING = "Alt"
	Ctrl_text: STRING = "Ctrl"
	Shift_text: STRING = "Shift"
	Shortcut_delimiter: STRING_32 = "+"

	w_preferences_delayed_resources: STRING_32
			-- Texts used in the dialog that tells the user
			-- they have to restart the application to use the new preferences.
		once
			Result := "The changes you have made to the following resources%Nwill be taken into account after you restart.%N%N"
		end

	Pixmaps_path_cell: CELL [PATH]
			-- Path where pixmaps for the preference window should be looked for.
			-- By default it looks in pixmaps in the current directory, but
			-- it is possible to change the contents of this cell to change this path.
		once
			create Result.put (create {PATH}.make_from_string ("pixmaps"))
		end

	Pixmaps_extension_cell: CELL [STRING]
			-- Extension for pixmaps.
		once
			create Result.put ("png")
		end

	preference_window_icon: STRING = "icon_preference_window";
		-- Base name of the file that contains the icon of the preferences window.

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class CONSTANTS
