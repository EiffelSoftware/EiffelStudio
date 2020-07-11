note
	description: "Miscellaneous preferences.  Please remove this class and put the preferences in the sensible places."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	make (a_preferences: PREFERENCES)
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

	dotnet_debugger: STRING = ""

	use_postscript: BOOLEAN
			-- Use postscript when printing
		do
			Result := use_postscript_preference.value
		end

	use_external_editor: BOOLEAN = False

	print_shell_command: STRING = "lpr $target"

	dyn_lib_window_width: INTEGER
			-- Initial width for the dialog.
		do
			Result := dyn_lib_window_width_preference.value
		end

	dyn_lib_window_height: INTEGER
			-- Initial width for the dialog.
		do
			Result := dyn_lib_window_height_preference.value
		end

	preference_window_width: INTEGER
			-- Initial width for the dialog.
		do
			Result := preference_window_width_preference.value
		end

	preference_window_height: INTEGER
			-- Initial width for the dialog.
		do
			Result := preference_window_height_preference.value
		end

	acrobat_reader: STRING
		do
			Result := acrobat_reader_preference.value
		end

	text_mode_is_windows: BOOLEAN
		do
			Result := text_mode_is_windows_preference.value
		end

	external_editor_command: STRING_32
		do
			Result := external_editor_command_preference.value
		ensure
			external_editor_command_not_void: Result /= Void
		end

	external_editor_cli (a_target: READABLE_STRING_GENERAL; a_line: INTEGER): like external_editor_command
			-- Update `external_editor_command' by replacing $target and
			-- $line with `a_target' and `a_line' to create a working command
			-- line.
		require
			a_line_positive: a_line > 0
		local
			s: STRING_32
		do
				-- Extract the command and adapt it if missing.
			Result := external_editor_command
			Result :=
				if Result.is_empty then
						-- Ensure that we have a working command.
					if {PLATFORM}.is_windows then
						{STRING_32} "notepad $target"
					else
						{STRING_32} "vi +$line $target"
					end
				else
					Result.twin
				end
				-- Replace $target and $line with the expected values
			if attached a_target then
				if a_target.count > 1 and a_target.code (1) /= ('"').code.as_natural_32 then
					create s.make (a_target.count + 2)
					s.append_character ('"')
					s.append_string_general (a_target)
					s.append_character ('"')
				else
					create s.make_from_string_general (a_target)
				end
			else
				create s.make_empty
			end
			Result.replace_substring_all ({STRING_32} "$target", s)
			create s.make (3)
			s.append_integer (a_line)
			Result.replace_substring_all ({STRING_32} "$line", s)
		ensure
			external_editor_cli_not_void: Result /= Void
			external_editor_cli_not_empty: not Result.is_empty
		end

	show_hidden_preferences: BOOLEAN
		do
			Result := show_hidden_preferences_preference.value
		end

	console_shell_command: STRING
			-- Shell to open a console
		do
			Result := console_shell_command_preference.value
		end

	file_browser_command: STRING_32
			-- Command to open a target in file browser
		do
			Result := file_browser_command_preference.value
		end

	web_browser_command: STRING_32
			-- Command to open a target in web browser
		do
			Result := internet_browser_preference.value
		end

	locale_id: STRING_32
			-- Locale ID of current language
		do
			Result := locale_id_preference.selected_value
		end

	is_pnd_mode: BOOLEAN
			-- Is current Pnd mode? If False, Contextual Menu mode.
		do
			Result := pnd_preference.value
		end

	update_channel: STRING
			-- Update channel name.
		do
			Result := {UTF_CONVERTER}.string_32_to_utf_8_string_8 (update_channel_preference.selected_value)
		end

	eis_path: STRING_32
			-- EIS path for project searching of incoming location
		do
			Result := eis_path_preference.value
		end

	terms_accepted: BOOLEAN
			-- License is accepted?
		do
			Result := terms_accepted_preference.value
		end

feature -- Element change

	set_terms_accepted (b: BOOLEAN)
			-- Set License accepted to `b`.
			-- Hidden.
		do
			terms_accepted_preference.set_value (b)
		end

feature -- Preference

	acrobat_reader_preference: STRING_PREFERENCE
	text_mode_is_windows_preference: BOOLEAN_PREFERENCE
	internet_browser_preference: STRING_32_PREFERENCE
	external_editor_command_preference: STRING_PREFERENCE
	dyn_lib_window_width_preference: INTEGER_PREFERENCE
	dyn_lib_window_height_preference: INTEGER_PREFERENCE
	preference_window_width_preference: INTEGER_PREFERENCE
	preference_window_height_preference: INTEGER_PREFERENCE
	show_hidden_preferences_preference: BOOLEAN_PREFERENCE
	console_shell_command_preference: STRING_PREFERENCE
	file_browser_command_preference: STRING_32_PREFERENCE
	locale_id_preference: ARRAY_32_PREFERENCE
	pnd_preference: BOOLEAN_PREFERENCE
	update_channel_preference: STRING_CHOICE_PREFERENCE
	eis_path_preference: STRING_32_PREFERENCE
	use_postscript_preference: BOOLEAN_PREFERENCE
	terms_accepted_preference: BOOLEAN_PREFERENCE

feature {NONE} -- Preference Strings

	acrobat_reader_string: STRING = "general.acrobat_reader"
	text_mode_is_windows_string: STRING = "editor.eiffel.text_mode_is_windows"
	internet_browser_string: STRING = "general.internet_browser"
	external_editor_command_string: STRING = "general.external_editor_command"
	dyn_lib_window_width_string: STRING = "general.dynamic_library_window_width"
	dyn_lib_window_height_string: STRING = "general.dynamic_library_window_height"
	preference_window_width_string: STRING = "general.preference_window_width"
	preference_window_height_string: STRING = "general.preference_window_height"
	show_hidden_preferences_string: STRING = "general.show_hidden_preferences"
	console_shell_command_string: STRING = "general.console_shell_command"
	file_browser_command_string: STRING = "general.file_browser_command"
	locale_id_preference_string: STRING = "general.locale"
	pnd_preference_string: STRING = "general.pick_and_drop_(pnd)_mode"
	update_channel_string: STRING = "general.update_channel"
	eis_path_preference_string: STRING = "general.eis_path"
	use_postscript_preference_string: STRING = "general.use_postscript"
	terms_accepted_preference_string: STRING = "general.terms_accepted"

feature {NONE} -- Implementation

	initialize_preferences
			-- Initialize preference values.
		local
			l_manager: EC_PREFERENCE_MANAGER
			l_eis_path: STRING_32
		do
			create l_manager.make (preferences, "misc")

			acrobat_reader_preference := l_manager.new_string_preference_value (l_manager, acrobat_reader_string, "acrobat")
			text_mode_is_windows_preference := l_manager.new_boolean_preference_value (l_manager, text_mode_is_windows_string, {PLATFORM}.is_windows)
			internet_browser_preference := l_manager.new_string_32_preference_value (l_manager, internet_browser_string, {STRING_32} "netscape $url")
			dyn_lib_window_height_preference := l_manager.new_integer_preference_value (l_manager, dyn_lib_window_height_string, 200)
			dyn_lib_window_width_preference := l_manager.new_integer_preference_value (l_manager, dyn_lib_window_width_string, 400)
			preference_window_height_preference := l_manager.new_integer_preference_value (l_manager, preference_window_height_string, 200)
			preference_window_width_preference := l_manager.new_integer_preference_value (l_manager, preference_window_width_string, 400)
			show_hidden_preferences_preference := l_manager.new_boolean_preference_value (l_manager, show_hidden_preferences_string, False)
			if {PLATFORM}.is_windows then
				console_shell_command_preference := l_manager.new_string_preference_value (l_manager, console_shell_command_string, "cmd")
				external_editor_command_preference := l_manager.new_string_preference_value (l_manager, external_editor_command_string, "notepad $target")
				file_browser_command_preference := l_manager.new_string_32_preference_value (l_manager, file_browser_command_string, {STRING_32} "explorer $target")
			else
				console_shell_command_preference := l_manager.new_string_preference_value (l_manager, console_shell_command_string, "xterm -geometry 80x40")
				file_browser_command_preference := l_manager.new_string_32_preference_value (l_manager, file_browser_command_string, {STRING_32} "xterm -geometry 80x40")
				external_editor_command_preference := l_manager.new_string_preference_value (l_manager, external_editor_command_string, "xterm -geometry 80x40 -e vi +$line $target")
			end

			locale_id_preference := l_manager.new_array_32_preference_value (l_manager, locale_id_preference_string, <<"Unselected">>)
			locale_id_preference.set_is_choice (True)
			init_locale
				-- Set the exact value, otherwise the preference detected default will be removed.
			locale_id_preference.set_default_value ("de_DE;[en_US];es_ES;fr_FR;ru_RU;zh_CN;Unselected")

			pnd_preference := l_manager.new_boolean_preference_value (l_manager, pnd_preference_string, False)

			update_channel_preference := l_manager.new_string_choice_preference_value (l_manager, update_channel_string, <<"stable", "beta">>)
			if update_channel_preference.selected_index = 0 then
				update_channel_preference.set_selected_index (1)
			end

			create l_eis_path.make_empty
			eis_path_preference := l_manager.new_string_32_preference_value (l_manager, eis_path_preference_string, l_eis_path)
			if attached eis_path as l_path and then l_path.is_empty then
				eis_path_preference.set_value (eiffel_layout.user_projects_path.name + {STRING_32} ";" + eiffel_layout.library_path.name)
			end

			use_postscript_preference := l_manager.new_boolean_preference_value (l_manager, use_postscript_preference_string, False)

			terms_accepted_preference := l_manager.new_boolean_preference_value (l_manager, terms_accepted_preference_string, False)
			terms_accepted_preference.set_hidden (True)
		end

	preferences: PREFERENCES
			-- Preferences

feature {NONE} -- Implementation

	init_locale
			-- Init available locales.
		require
			locale_id_preference_not_void: locale_id_preference /= Void
		local
			l_select_lang: STRING_32
			l_id: I18N_LOCALE_ID
			l_available_lang: STRING_32
			l_available_locales: LIST [I18N_LOCALE_ID]
			l_str: STRING_32
			l_added_pre: HASH_TABLE [STRING_32, STRING_32]
			l_found, l_is_unselected: BOOLEAN
			l_set_default_locale: BOOLEAN
		do
			if is_gui then
				l_select_lang := locale_id_preference.selected_value
				if l_select_lang = Void or else l_select_lang.same_string (default_string) then
					l_is_unselected := True

					if is_eiffel_layout_defined then
						if attached eiffel_layout.get_environment_32 ("ISE_LANG") as l_lang then
							l_select_lang := l_lang.to_string_8
						end
						l_is_unselected := l_select_lang = Void or else l_select_lang.is_empty or else l_select_lang.same_string (default_string)
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
						l_str := l_available_locales.item.name
						if not l_added_pre.has (l_str) then
							l_added_pre.force (l_str, l_str)
							if l_available_locales.item.is_equal (l_id) and then not l_is_unselected then
									-- Set this item selected.
									-- And activate this locale.
								set_locale_with_id (l_str)
								l_str := {STRING_32} "[" + l_str + "]"
								l_found := True
							end
							l_available_lang.append (l_str)
							l_available_lang.extend (';')
						end
					end
					l_available_locales.forth
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
					if attached eiffel_layout.get_environment_32 ("ISE_LANG") as l_lang then
						l_select_lang := l_lang
					end
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

	default_string: STRING = "Unselected";

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
	update_channel_preference_not_void: update_channel_preference /= Void
	eis_preference_not_void: eis_path_preference /= Void
	use_postscript_preference_not_void: use_postscript_preference /= Void
	terms_accepted_preference_not_void: terms_accepted_preference /= Void

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
