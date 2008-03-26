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
	SHARED_LOCALE

	SHARED_FLAGS

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

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

feature -- Value

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
		ensure
			external_editor_command_not_void: Result /= Void
		end

	external_editor_cli (a_target: STRING; a_line: INTEGER): STRING is
			-- Update `external_editor_command' by replacing $target and
			-- $line with `a_target' and `a_line' to create a working command
			-- line.
		require
			a_line_positive: a_line > 0
		local
			l_target: STRING
		do
				-- Extract the command and adapt it if missing.
			Result := external_editor_command
			if Result.is_empty then
					-- Ensure that we have a working command.
				if {PLATFORM}.is_windows then
					Result := "notepad $target"
				else
					Result := "vi +$line $target"
				end
			else
				Result := Result.twin
			end
				-- Replace $target and $line with the expected values
			if a_target /= Void then
				if a_target.count > 1 and a_target.item (1) /= '"' then
					l_target := a_target.twin
					l_target.prepend_character ('"')
					l_target.append_character ('"')
				else
					l_target := a_target
				end
			else
				l_target := ""
			end
			check l_target_not_void: l_target /= Void end
			Result.replace_substring_all ("$target", l_target)
			Result.replace_substring_all ("$line", a_line.out)
		ensure
			external_editor_cli_not_void: Result /= Void
			external_editor_cli_not_empty: not Result.is_empty
		end

	show_hidden_preferences: BOOLEAN is
		do
			Result := show_hidden_preferences_preference.value
		end

	console_shell_command: STRING is
			-- Shell to open a console
		do
			Result := console_shell_command_preference.value
		end

	file_browser_command: STRING is
			-- Command to open a target in file browser
		do
			Result := file_browser_command_preference.value
		end

	locale_id: STRING is
			-- Locale ID of current language
		do
			Result := locale_id_preference.selected_value
		end

	is_pnd_mode: BOOLEAN is
			-- Is current Pnd mode? If False, Contextual Menu mode.
		do
			Result := pnd_preference.value
		end

feature -- Preference

	acrobat_reader_preference: STRING_PREFERENCE
	text_mode_is_windows_preference: BOOLEAN_PREFERENCE
	internet_browser_preference: STRING_PREFERENCE
	external_editor_command_preference: STRING_PREFERENCE
	dyn_lib_window_width_preference: INTEGER_PREFERENCE
	dyn_lib_window_height_preference: INTEGER_PREFERENCE
	preference_window_width_preference: INTEGER_PREFERENCE
	preference_window_height_preference: INTEGER_PREFERENCE
	show_hidden_preferences_preference: BOOLEAN_PREFERENCE
	console_shell_command_preference: STRING_PREFERENCE
	file_browser_command_preference: STRING_PREFERENCE
	locale_id_preference: ARRAY_PREFERENCE
	pnd_preference: BOOLEAN_PREFERENCE

feature {NONE} -- Preference Strings

	acrobat_reader_string: STRING is "general.acrobat_reader"
	text_mode_is_windows_string: STRING is "editor.eiffel.text_mode_is_windows"
	internet_browser_string: STRING is "general.internet_browser"
	external_editor_command_string: STRING is "general.external_editor_command"
	dyn_lib_window_width_string: STRING is "general.dynamic_library_window_width"
	dyn_lib_window_height_string: STRING is "general.dynamic_library_window_height"
	preference_window_width_string: STRING is "general.preference_window_width"
	preference_window_height_string: STRING is "general.preference_window_height"
	show_hidden_preferences_string: STRING is "general.show_hidden_preferences"
	console_shell_command_string: STRING is "general.console_shell_command"
	file_browser_command_string: STRING is "general.file_browser_command"
	locale_id_preference_string: STRING is "general.locale"
	pnd_preference_string: STRING is "general.pnd_mode"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EC_PREFERENCE_MANAGER
			l_platform: PLATFORM_CONSTANTS
		do
			create l_platform
			create l_manager.make (preferences, "misc")

			acrobat_reader_preference := l_manager.new_string_preference_value (l_manager, acrobat_reader_string, "acrobat")
			text_mode_is_windows_preference := l_manager.new_boolean_preference_value (l_manager, text_mode_is_windows_string, l_platform.is_windows)
			internet_browser_preference := l_manager.new_string_preference_value (l_manager, internet_browser_string, "netscape $url")
			dyn_lib_window_height_preference := l_manager.new_integer_preference_value (l_manager, dyn_lib_window_height_string, 200)
			dyn_lib_window_width_preference := l_manager.new_integer_preference_value (l_manager, dyn_lib_window_width_string, 400)
			preference_window_height_preference := l_manager.new_integer_preference_value (l_manager, preference_window_height_string, 200)
			preference_window_width_preference := l_manager.new_integer_preference_value (l_manager, preference_window_width_string, 400)
			show_hidden_preferences_preference := l_manager.new_boolean_preference_value (l_manager, show_hidden_preferences_string, False)
			if l_platform.is_windows then
				console_shell_command_preference := l_manager.new_string_preference_value (l_manager, console_shell_command_string, "cmd")
				external_editor_command_preference := l_manager.new_string_preference_value (l_manager, external_editor_command_string, "notepad $target")
				file_browser_command_preference := l_manager.new_string_preference_value (l_manager, file_browser_command_string, "explorer $target")
			else
				console_shell_command_preference := l_manager.new_string_preference_value (l_manager, console_shell_command_string, "xterm -geometry 80x40")
				file_browser_command_preference := l_manager.new_string_preference_value (l_manager, file_browser_command_string, "xterm -geometry 80x40")
				external_editor_command_preference := l_manager.new_string_preference_value (l_manager, external_editor_command_string, "xterm -geometry 80x40 -e vi +$line $target")
			end
			locale_id_preference := l_manager.new_array_preference_value (l_manager, locale_id_preference_string, <<"Unselected">>)
			locale_id_preference.set_is_choice (True)
			init_locale

			pnd_preference := l_manager.new_boolean_preference_value (l_manager, pnd_preference_string, False)
		end

	preferences: PREFERENCES
			-- Preferences

feature {NONE} -- Implementation

	init_locale is
			-- Init available locales.
		require
			locale_id_preference_not_void: locale_id_preference /= Void
		local
			l_select_lang: STRING
			l_id: I18N_LOCALE_ID
			l_available_lang: STRING
			l_available_locales: LIST [I18N_LOCALE_ID]
			l_str: STRING
			l_added_pre: HASH_TABLE [STRING, STRING]
			l_found, l_is_unselected: BOOLEAN
			l_set_default_locale: BOOLEAN
		do
			if is_gui then
				l_select_lang := locale_id_preference.selected_value
				if l_select_lang = Void or else l_select_lang.is_equal (default_string) then
					l_is_unselected := True

					if is_eiffel_layout_defined then
						l_select_lang := eiffel_layout.get_environment ("ISE_LANG")
						l_is_unselected := l_select_lang = Void or else l_select_lang.is_empty or else l_select_lang.is_equal (default_string)
					end

					if l_is_unselected then
						l_select_lang := default_string
					end
				end
				check
					l_select_lang_attached: l_select_lang /= Void
				end

				l_available_locales := locale_manager.available_locales
				create l_id.make_from_string (l_select_lang)
				if not locale_manager.has_translations (l_id) then
					create l_id.make_from_string ("en_US")
				end
				create l_added_pre.make (100)
				create l_available_lang.make (20)
				from
					l_available_locales.start
				until
					l_available_locales.after
				loop
					if locale_manager.has_translations (l_available_locales.item) then
						check
							name_of_locale_id_is_string_8: l_available_locales.item.name.is_valid_as_string_8
						end
						l_str := l_available_locales.item.name.as_string_8
						if not l_added_pre.has (l_str) then
							if not l_added_pre.is_empty then
								l_available_lang.extend (';')
							end
							l_added_pre.force (l_str, l_str)
							if l_available_locales.item.is_equal (l_id) and then not l_is_unselected then
									-- Set this item selected.
									-- And activate this locale.
								set_locale_with_id (l_str)
								l_str := "[" + l_str + "]"
								l_found := True
							end
							l_available_lang.append (l_str)
						end
					end
					l_available_locales.forth
				end
				if not l_available_lang.is_empty then
					l_available_lang.extend (';')
				end
				if not l_found then
						-- If previous selected locale is not found anymore,
						-- or neither possible try of "en_US" is found,
						-- We select "Unselected" entry, and set locale to be empty.
					l_available_lang.append ("[" + default_string + "]")
					set_empty_locale
				else
					l_available_lang.append (default_string)
				end
				locale_id_preference.set_value_from_string (l_available_lang)
			else
				if is_eiffel_layout_defined then
					l_select_lang := eiffel_layout.get_environment ("ISE_LANG")
					if l_select_lang /= Void and then not l_select_lang.is_empty then
						create l_id.make_from_string (l_select_lang)
						if locale_manager.has_locale (l_id) then
							set_locale_with_id (l_select_lang)
						else
							l_set_default_locale := True
						end
					else
						l_set_default_locale := True
					end
				else
					l_set_default_locale := True
				end

				if l_set_default_locale then
					set_system_locale
				end
			end
		end

	default_string: STRING is "Unselected";

invariant
	preferences_not_void: preferences /= Void
	acrobat_reader_preference_not_void: acrobat_reader_preference /= Void
	text_mode_is_windows_preference_not_void: text_mode_is_windows_preference /= Void
	general_shell_command_preference_not_void: external_editor_command_preference /= Void
	dyn_lib_window_width_preference_not_void: dyn_lib_window_width_preference /= Void
	dyn_lib_window_height_preference_not_void: dyn_lib_window_height_preference /= Void
	preference_window_width_preference_not_void: preference_window_width_preference /= Void
	preference_window_height_preference_not_void: preference_window_height_preference /= Void
	console_shell_command_preference_not_void: console_shell_command_preference /= Void
	locale_id_preference_not_void: locale_id_preference /= Void
	pnd_preference_not_void: pnd_preference /= Void

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
