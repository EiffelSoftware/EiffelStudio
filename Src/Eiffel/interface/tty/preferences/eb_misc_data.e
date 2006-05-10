indexing
	description: "Miscellaneous preferences.  Please remove this class and put the preferences in the sensible places."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	preference_window_width: INTEGER is
			-- Initial width for the dialog.
		do
			Result := preference_window_width_preference.value
		end

	preference_window_height: INTEGER is
			-- Initial width for the dialog.
		do
			Result := preference_window_height_preference.value
		end

	acrobat_reader: STRING is
		do
			Result := acrobat_reader_preference.value
		end

	text_mode_is_windows: BOOLEAN is
		do
			Result := text_mode_is_windows_preference.value
		end

	external_editor_command: STRING is
		do
			Result := external_editor_command_preference.value
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

	i_th_external_preference_string (i: INTEGER): STRING is
			--
		do
			Result := i_th_external_preference (i).name
		end

	editor_left_side: BOOLEAN is
		do
			Result := editor_left_side_preference.value
		end

	show_hidden_preferences: BOOLEAN is
		do
			Result := show_hidden_preferences_preference.value
		end

	default_displayed_string_size: INTEGER is
			-- Default size of string to be retrieved from the application
			-- when debugging (for instance size of `string_value' in ABSTRACT_REFERENCE_VALUE)
			-- (Default value is 50)
		do
			Result := default_displayed_string_size_preference.value
		end

	console_shell_command: STRING is
			-- Shell to open a console
		do
			Result := console_shell_command_preference.value
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
	internet_browser_preference: STRING_PREFERENCE
	external_editor_command_preference: STRING_PREFERENCE
	dyn_lib_window_width_preference: INTEGER_PREFERENCE
	dyn_lib_window_height_preference: INTEGER_PREFERENCE
	preference_window_width_preference: INTEGER_PREFERENCE
	preference_window_height_preference: INTEGER_PREFERENCE
	editor_left_side_preference: BOOLEAN_PREFERENCE
	default_displayed_string_size_preference: INTEGER_PREFERENCE
	show_hidden_preferences_preference: BOOLEAN_PREFERENCE
	console_shell_command_preference: STRING_PREFERENCE

feature {NONE} -- Preference Strings

	external_command_0_string: STRING is "general.external_command_0"
	external_command_1_string: STRING is "general.external_command_1"
	external_command_2_string: STRING is "general.external_command_2"
	external_command_3_string: STRING is "general.external_command_3"
	external_command_4_string: STRING is "general.external_command_4"
	external_command_5_string: STRING is "general.external_command_5"
	external_command_6_string: STRING is "general.external_command_6"
	external_command_7_string: STRING is "general.external_command_7"
	external_command_8_string: STRING is "general.external_command_8"
	external_command_9_string: STRING is "general.external_command_9"
	acrobat_reader_string: STRING is "general.acrobat_reader"
	text_mode_is_windows_string: STRING is "editor.eiffel.text_mode_is_windows"
	internet_browser_string: STRING is "general.internet_browser"
	external_editor_command_string: STRING is "general.external_editor_command"
	editor_left_side_string: STRING is "interface.development_window.editor_left_side"
	dyn_lib_window_width_string: STRING is "general.dynamic_library_window_width"
	dyn_lib_window_height_string: STRING is "general.dynamic_library_window_height"
	preference_window_width_string: STRING is "general.preference_window_width"
	preference_window_height_string: STRING is "general.preference_window_height"
	default_displayed_string_size_string: STRING is "debugger.default_displayed_string_size"
	show_hidden_preferences_string: STRING is "general.show_hidden_preferences"
	console_shell_command_string: STRING is "general.console_shell_command"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EC_PREFERENCE_MANAGER
			l_platform: PLATFORM_CONSTANTS
		do
			create l_platform
			create l_manager.make (preferences, "misc")

			external_command_0_preference := l_manager.new_string_preference_value (l_manager, external_command_0_string, "")
			external_commands.put (external_command_0_preference, 0)
			external_command_1_preference := l_manager.new_string_preference_value (l_manager, external_command_1_string, "")
			external_commands.put (external_command_1_preference, 1)
			external_command_2_preference := l_manager.new_string_preference_value (l_manager, external_command_2_string, "")
			external_commands.put (external_command_2_preference, 2)
			external_command_3_preference := l_manager.new_string_preference_value (l_manager, external_command_3_string, "")
			external_commands.put (external_command_3_preference, 3)
			external_command_4_preference := l_manager.new_string_preference_value (l_manager, external_command_4_string, "")
			external_commands.put (external_command_4_preference, 4)
			external_command_5_preference := l_manager.new_string_preference_value (l_manager, external_command_5_string, "")
			external_commands.put (external_command_5_preference, 5)
			external_command_6_preference := l_manager.new_string_preference_value (l_manager, external_command_6_string, "")
			external_commands.put (external_command_6_preference, 6)
			external_command_7_preference := l_manager.new_string_preference_value (l_manager, external_command_7_string, "")
			external_commands.put (external_command_7_preference, 7)
			external_command_8_preference := l_manager.new_string_preference_value (l_manager, external_command_8_string, "")
			external_commands.put (external_command_8_preference, 8)
			external_command_9_preference := l_manager.new_string_preference_value (l_manager, external_command_9_string, "")
			external_commands.put (external_command_9_preference, 9)

			acrobat_reader_preference := l_manager.new_string_preference_value (l_manager, acrobat_reader_string, "acrobat")
			text_mode_is_windows_preference := l_manager.new_boolean_preference_value (l_manager, text_mode_is_windows_string, l_platform.is_windows)
			internet_browser_preference := l_manager.new_string_preference_value (l_manager, internet_browser_string, "netscape $url")
			editor_left_side_preference := l_manager.new_boolean_preference_value (l_manager, editor_left_side_string, False)
			dyn_lib_window_height_preference := l_manager.new_integer_preference_value (l_manager, dyn_lib_window_height_string, 200)
			dyn_lib_window_width_preference := l_manager.new_integer_preference_value (l_manager, dyn_lib_window_width_string, 400)
			preference_window_height_preference := l_manager.new_integer_preference_value (l_manager, preference_window_height_string, 200)
			preference_window_width_preference := l_manager.new_integer_preference_value (l_manager, preference_window_width_string, 400)
			default_displayed_string_size_preference := l_manager.new_integer_preference_value (l_manager, default_displayed_string_size_string, 50)
			show_hidden_preferences_preference := l_manager.new_boolean_preference_value (l_manager, show_hidden_preferences_string, False)
			if l_platform.is_windows then
				console_shell_command_preference := l_manager.new_string_preference_value (l_manager, console_shell_command_string, "cmd")
				external_editor_command_preference := l_manager.new_string_preference_value (l_manager, external_editor_command_string, "notepad $target")
			else
				console_shell_command_preference := l_manager.new_string_preference_value (l_manager, console_shell_command_string, "xterm -geometry 80x40")
				external_editor_command_preference := l_manager.new_string_preference_value (l_manager, external_editor_command_string, "xterm -geometry 80x40 -e vi +$line $target")
			end
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
	general_shell_command_preference_not_void: external_editor_command_preference /= Void
	dyn_lib_window_width_preference_not_void: dyn_lib_window_width_preference /= Void
	dyn_lib_window_height_preference_not_void: dyn_lib_window_height_preference /= Void
	preference_window_width_preference_not_void: preference_window_width_preference /= Void
	preference_window_height_preference_not_void: preference_window_height_preference /= Void
	editor_left_side_preference_not_void: editor_left_side_preference /= Void
	default_displayed_string_size_preference_not_void: default_displayed_string_size_preference /= Void
	console_shell_command_preference_not_void: console_shell_command_preference /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_MISC_DATA
