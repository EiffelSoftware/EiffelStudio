note
	description: "Objects that provide access to constants loaded from files."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCES_GRID_CONSTANTS

inherit
	EV_LAYOUT_CONSTANTS

feature -- Access

	l_name: STRING_GENERAL				do Result := "Name" end
	l_literal_value: STRING_GENERAL		do Result := "Literal Value" end
	l_status: STRING_GENERAL				do Result := "Status" end
	l_type: STRING_GENERAL				do Result := "Type" end
	l_request_restart: STRING_GENERAL	do Result := " (REQUIRES RESTART)" end
	l_tree_view: STRING_GENERAL			do Result := "Tree View" end
	f_switch_to_tree_view: STRING_GENERAL do Result := "Switch to Tree View" end
	l_flat_view: STRING_GENERAL			do Result := "Flat View" end
	f_switch_to_flat_view: STRING_GENERAL do Result := "Switch to Flat View" end

	l_matches_of_total_preferences (a_count: INTEGER; a_total_count: INTEGER): STRING_GENERAL
		do
			Result := a_count.out + " matches of " + a_total_count.out + " total preferences"
		end

	l_count_preferences (a_count: STRING_GENERAL): STRING_GENERAL
		require
			a_count_not_void: a_count /= Void
		do
			Result := a_count.as_string_32 + " preferences"
		end

	l_updating_the_view: STRING_GENERAL 	do Result := "Updating the view ..." end
	l_filter: STRING_GENERAL				do Result := "Filter:" end
	l_filter_value: STRING_GENERAL			do Result := "Include Values?" end
	l_tree_or_flat_view: STRING_GENERAL		do Result := "Tree/Flat View" end
	l_restore_defaults: STRING_GENERAL 		do Result := "Restore Defaults" end
	l_import_preferences: STRING_GENERAL 	do Result := "Import ..." end
	l_export_preferences: STRING_GENERAL 	do Result := "Export ..." end
	l_restore_default: STRING_GENERAL		do Result := "Restore Default" end
	l_no_default_value: STRING_GENERAL 		do Result := "No default value" end
	l_close: STRING_GENERAL					do Result := "Close" end
	l_apply: STRING_GENERAL					do Result := "Apply" end
	l_display_window: STRING_GENERAL 		do Result := "Display window" end
	l_description: STRING_GENERAL			do Result := "Description" end
	l_building_flat_view: STRING_GENERAL	do Result := "Building flat view ..." end
	l_building_tree_view: STRING_GENERAL	do Result := "Building tree view ..." end


	p_default_value: STRING_GENERAL		do Result := "default" end
	user_value: STRING_GENERAL			do Result := "user set" end
	auto_value: STRING_GENERAL			do Result := "auto" end
	no_description_text: STRING_GENERAL	do Result := "No description available for this preference." end
	preferences_title: STRING_GENERAL 	do Result := "Preferences" end
	restore_preference_string: STRING_GENERAL do Result := "This will reset ALL preferences to their default values%N and all previous settings will be overwritten.  Are you sure?" end
	shortcut_modification_denied: STRING_GENERAL do Result := "Shortcut modification failed. It is either used by a fixed shortcut or reserved by the system." end
	preferenese_root: STRING_GENERAL do Result := "Preferences root" end

	Alt_text: STRING = "Alt"
	Ctrl_text: STRING = "Ctrl"
	Shift_text: STRING = "Shift"
	Shortcut_delimiter: STRING = "+"

	w_Preferences_delayed_resources: STRING_GENERAL
			-- Texts used in the dialog that tells the user
			-- they have to restart the application to use the new preferences.
		once
			Result := "The changes you have made to the following resources%Nwill be taken into account after you restart.%N%N"
		end

	Pixmaps_path_cell: CELL [STRING]
			-- Path where pixmaps for the preference window should be looked for.
			-- By default it looks in pixmaps in the current directory, but
			-- it is possible to change the contents of this cell to change this path.
		once
			create Result.put ("pixmaps")
		end

	Pixmaps_extension_cell: CELL [STRING]
			-- Extension for pixmaps.
		once
			create Result.put ("png")
		end

	preference_window_icon: STRING = "icon_preference_window";
		-- Base name of the file that contains the icon of the preferences window.

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class PREFERENCES_GRID_CONSTANTS
