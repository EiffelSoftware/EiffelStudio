indexing
	description: "Miscellaneous preferences.  Please remove this class and put the preferences in the sensible places."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_MISC_DATA
	
inherit	
	EIFFEL_ENV

create
	make

feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			initialize_preferences
		ensure
			preferences_not_void: preferences /= Void
		end		

feature {EB_SHARED_PREFERENCES} -- Value

	dotnet_debugger: STRING is ""
	
	use_postscript: BOOLEAN is False

	use_external_editor: BOOLEAN is False
	
	print_shell_command: STRING is "lpr $target"
	
	ctrl_right_click_receiver: STRING is
			-- 
		do
			Result := ctrl_right_click_receiver_preference.selected_value
		end
		
	dyn_lib_window_width: INTEGER is
			-- Initial width for the dialog.
		do
			Result := dyn_lib_window_width_preference.value
		end

	dyn_lib_window_height: INTEGER is
			-- Initial width for the dialog.
		do
			Result := dyn_lib_window_height_preference.value
		end
	
	acrobat_reader: STRING is
		do
			Result := acrobat_reader_preference.value
		end

	text_mode_is_windows: BOOLEAN is
		do
			Result := text_mode_is_windows_preference.value
		end
		
	shell_editor: STRING is
		do
			Result := shell_editor_preference.value
		end

	general_shell_command: STRING is
		do
			Result := general_shell_command_preference.value
		end

	general_filter_name: STRING is
		do
			Result := general_filter_name_preference.value
		end

	general_filter_command: STRING is
		do
			Result := general_filter_command_preference.value
		end

	general_filter_path: STRING is
		do
			Result := general_filter_path_preference.value
		end

	general_profile_path: STRING is
		do
			Result := general_profile_path_preference.value
		end

	general_tmp_path: STRING is
		do
			Result := general_tmp_path_preference.value
		end

	browsing_facilities: BOOLEAN is
		do
			Result := browsing_facilities_preference.value
		end
	
	external_command_0: STRING is
			-- 
		do
			Result := external_commands.item (1).value
		end

	external_command_1: STRING is
			-- 
		do
			Result := external_commands.item (2).value
		end
		
	external_command_2: STRING is
			-- 
		do
			Result := external_commands.item (3).value
		end
		
	external_command_3: STRING is
			-- 
		do
			Result := external_commands.item (4).value
		end
		
	external_command_4: STRING is
			-- 
		do
			Result := external_commands.item (5).value
		end
		
	external_command_5: STRING is
			-- 
		do
			Result := external_commands.item (6).value
		end
		
	external_command_6: STRING is
			-- 
		do
			Result := external_commands.item (7).value
		end
		
	external_command_7: STRING is
			-- 
		do
			Result := external_commands.item (8).value
		end
		
	external_command_8: STRING is
			-- 
		do
			Result := external_commands.item (9).value
		end
		
	external_command_9: STRING is
			-- 
		do
			Result := external_commands.item (10).value
		end

	i_th_external_preference_value (i: INTEGER): STRING is
			-- 
		do
			Result := i_th_external_preference (i).value
		end

	editor_left_side: BOOLEAN is 
		do
			Result := editor_left_side_preference.value
		end	

feature {EB_SHARED_PREFERENCES} -- Preference

	external_command_0_preference: STRING_PREFERENCE
	external_command_1_preference: STRING_PREFERENCE
	external_command_2_preference: STRING_PREFERENCE
	external_command_3_preference: STRING_PREFERENCE
	external_command_4_preference: STRING_PREFERENCE
	external_command_5_preference: STRING_PREFERENCE
	external_command_6_preference: STRING_PREFERENCE
	external_command_7_preference: STRING_PREFERENCE
	external_command_8_preference: STRING_PREFERENCE
	external_command_9_preference: STRING_PREFERENCE

	external_commands: ARRAY [STRING_PREFERENCE] is
			-- 
		once
			create Result.make (0, 9)
		end		

	i_th_external_preference (i: INTEGER): STRING_PREFERENCE is
			-- 
		do
			Result := external_commands.item (i)
		end

	acrobat_reader_preference: STRING_PREFERENCE
	text_mode_is_windows_preference: BOOLEAN_PREFERENCE
	shell_editor_preference: STRING_PREFERENCE
	internet_browser_preference: STRING_PREFERENCE
	general_shell_command_preference: STRING_PREFERENCE
	general_filter_name_preference: STRING_PREFERENCE
	general_filter_command_preference: STRING_PREFERENCE
	general_filter_path_preference: STRING_PREFERENCE
	general_profile_path_preference: STRING_PREFERENCE
	general_tmp_path_preference: STRING_PREFERENCE
	browsing_facilities_preference: BOOLEAN_PREFERENCE
	ctrl_right_click_receiver_preference: ARRAY_PREFERENCE	
	dyn_lib_window_width_preference: INTEGER_PREFERENCE	
	dyn_lib_window_height_preference: INTEGER_PREFERENCE	
	editor_left_side_preference: BOOLEAN_PREFERENCE

feature {NONE} -- Preference Strings

	external_command_0_string: STRING is "misc.external_command_0"
	external_command_1_string: STRING is "misc.external_command_1"
	external_command_2_string: STRING is "misc.external_command_2"
	external_command_3_string: STRING is "misc.external_command_3"
	external_command_4_string: STRING is "misc.external_command_4"
	external_command_5_string: STRING is "misc.external_command_5"
	external_command_6_string: STRING is "misc.external_command_6"
	external_command_7_string: STRING is "misc.external_command_7"
	external_command_8_string: STRING is "misc.external_command_8"
	external_command_9_string: STRING is "misc.external_command_9"
	acrobat_reader_string: STRING is "misc.acrobat_reader"
	text_mode_is_windows_string: STRING is "misc.text_mode_is_windows"
	shell_editor_string: STRING is "misc.editor"
	internet_browser_string: STRING is "misc.internet_browser"
	general_shell_command_string: STRING is "misc.shell_command"
	general_filter_name_string: STRING is "misc.filter_name"
	general_filter_command_string: STRING is "misc.filter_command"
	general_filter_path_string: STRING is "misc.filter_directory"
	general_profile_path_string: STRING is "misc.profile_directory"
	general_tmp_path_string: STRING is "misc.temporary_directory"
	browsing_facilities_string: STRING is "misc.highlight clickable areas"
	editor_left_side_string: STRING is "misc.editor_left_side"
	dyn_lib_window_width_string: STRING is "misc.dyn_lib_window_width"
	dyn_lib_window_height_string: STRING is "misc.dyn_lib_window_height"
	ctrl_right_click_receiver_string: STRING is "ctrl_right_click_receiver"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
			l_ext_pref: STRING_PREFERENCE
		do								
			create l_manager.make (preferences, "misc")	
			
			external_command_0_preference := l_manager.new_string_resource_value (l_manager, external_command_0_string, "")
			external_commands.put (external_command_0_preference, 0)
			external_command_1_preference := l_manager.new_string_resource_value (l_manager, external_command_1_string, "")
			external_commands.put (external_command_0_preference, 1)
			external_command_2_preference := l_manager.new_string_resource_value (l_manager, external_command_2_string, "")
			external_commands.put (external_command_0_preference, 2)
			external_command_3_preference := l_manager.new_string_resource_value (l_manager, external_command_3_string, "")
			external_commands.put (external_command_0_preference, 3)
			external_command_4_preference := l_manager.new_string_resource_value (l_manager, external_command_4_string, "")
			external_commands.put (external_command_0_preference, 4)
			external_command_5_preference := l_manager.new_string_resource_value (l_manager, external_command_5_string, "")
			external_commands.put (external_command_0_preference, 5)
			external_command_6_preference := l_manager.new_string_resource_value (l_manager, external_command_6_string, "")
			external_commands.put (external_command_0_preference, 6)
			external_command_7_preference := l_manager.new_string_resource_value (l_manager, external_command_7_string, "")
			external_commands.put (external_command_0_preference, 7)
			external_command_8_preference := l_manager.new_string_resource_value (l_manager, external_command_8_string, "")
			external_commands.put (external_command_0_preference, 8)
			external_command_9_preference := l_manager.new_string_resource_value (l_manager, external_command_9_string, "")
			external_commands.put (external_command_0_preference, 9)

			acrobat_reader_preference := l_manager.new_string_resource_value (l_manager, acrobat_reader_string, "acrobat")
			text_mode_is_windows_preference := l_manager.new_boolean_resource_value (l_manager, text_mode_is_windows_string, (create {PLATFORM_CONSTANTS}).is_windows)						
			shell_editor_preference := l_manager.new_string_resource_value (l_manager, shell_editor_string, "vi")
			internet_browser_preference := l_manager.new_string_resource_value (l_manager, internet_browser_string, "netscape $url")
			general_shell_command_preference := l_manager.new_string_resource_value (l_manager, general_shell_command_string, "xterm -geometry 80x40 -e vi +$line $target")			
			general_filter_name_preference := l_manager.new_string_resource_value (l_manager, general_filter_name_string, "PostScript")			
			general_filter_command_preference := l_manager.new_string_resource_value (l_manager, general_filter_command_string, "")			
			general_filter_path_preference := l_manager.new_string_resource_value (l_manager, general_filter_path_string, filter_path.twin)			
			general_profile_path_preference := l_manager.new_string_resource_value (l_manager, general_profile_path_string, profile_path.twin)			
			general_tmp_path_preference := l_manager.new_string_resource_value (l_manager, general_tmp_path_string, tmp_directory.twin)			
			browsing_facilities_preference:= l_manager.new_boolean_resource_value (l_manager, browsing_facilities_string, True)						
			editor_left_side_preference := l_manager.new_boolean_resource_value (l_manager, editor_left_side_string, False)
			dyn_lib_window_height_preference := l_manager.new_integer_resource_value (l_manager, dyn_lib_window_height_string, 200)
			dyn_lib_window_width_preference := l_manager.new_integer_resource_value (l_manager, dyn_lib_window_width_string, 400)	
			ctrl_right_click_receiver_preference := l_manager.new_array_resource_value (l_manager, ctrl_right_click_receiver_string, <<"new_window">>)	
		end
	
	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void	
	external_command_0_preference_not_void: external_command_0_preference /= Void
	external_command_1_preference_not_void: external_command_1_preference /= Void
	external_command_2_preference_not_void: external_command_2_preference /= Void
	external_command_3_preference_not_void: external_command_3_preference /= Void
	external_command_4_preference_not_void: external_command_4_preference /= Void
	external_command_5_preference_not_void: external_command_5_preference /= Void
	external_command_6_preference_not_void: external_command_6_preference /= Void
	external_command_7_preference_not_void: external_command_7_preference /= Void
	external_command_8_preference_not_void: external_command_8_preference /= Void
	external_command_9_preference_not_void: external_command_9_preference /= Void
	acrobat_reader_preference_not_void: acrobat_reader_preference /= Void
	text_mode_is_windows_preference_not_void: text_mode_is_windows_preference /= Void	
	shell_editor_preference_not_void: shell_editor_preference /= Void
	general_shell_command_preference_not_void: general_shell_command_preference /= Void
	general_filter_name_preference_not_void: general_filter_name_preference /= Void
	general_filter_command_preference_not_void: general_filter_command_preference /= Void
	general_filter_path_preference_not_void: general_filter_path_preference /= Void
	general_profile_path_preference_not_void: general_profile_path_preference /= Void
	general_tmp_path_preference_not_void: general_tmp_path_preference /= Void
	browsing_facilities_preference_not_void: browsing_facilities_preference /= Void	
	ctrl_right_click_receiver_preference_not_void: ctrl_right_click_receiver_preference /= Void
	dyn_lib_window_width_preference_not_void: dyn_lib_window_width_preference /= Void
	dyn_lib_window_height_preference_not_void: dyn_lib_window_height_preference /= Void
	editor_left_side_preference_not_void: editor_left_side_preference /= Void

end -- class EB_MISC_DATA
