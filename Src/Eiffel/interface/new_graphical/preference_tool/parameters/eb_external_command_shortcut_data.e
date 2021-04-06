note
	description: "Preferences for external commands."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNAL_COMMAND_SHORTCUT_DATA

inherit
	EB_SHORTCUTS_DATA

	EV_KEY_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {EB_PREFERENCES} -- Initialization

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

feature {EB_SHARED_PREFERENCES} -- Access

	shortcuts: STRING_TABLE [SHORTCUT_PREFERENCE]
			-- Shortcuts
		once
			create Result.make (default_shortcut_actions.count)
		end

feature {NONE} -- Preference Strings

	initialize_preferences
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_manager.make (preferences, "shortcuts.external_commands")
			initialize_shortcuts_prefs (l_manager)
		end

	preferences: PREFERENCES
			-- Preferences

feature {NONE} -- Shortcuts

	default_shortcut_actions: ARRAYED_LIST [TUPLE [actions: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING_8], STRING_8]; group: MANAGED_SHORTCUT_GROUP]]
			-- Array of shortcut defaults (Alt/Ctrl/Shift/KeyString)
		local
			l_hash: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING], STRING]
		once
			create Result.make (1)
			create l_hash.make (25)
			l_hash.put ([True, False,  False, key_strings.item (Key_0).twin.as_string_8], "shortcut_0")
			l_hash.put ([True, False,  False, key_strings.item (Key_1).twin.as_string_8], "shortcut_1")
			l_hash.put ([True, False,  False, key_strings.item (Key_2).twin.as_string_8], "shortcut_2")
			l_hash.put ([True, False,  False, key_strings.item (Key_3).twin.as_string_8], "shortcut_3")
			l_hash.put ([True, False,  False, key_strings.item (Key_4).twin.as_string_8], "shortcut_4")
			l_hash.put ([True, False,  False, key_strings.item (Key_5).twin.as_string_8], "shortcut_5")
			l_hash.put ([True, False,  False, key_strings.item (Key_6).twin.as_string_8], "shortcut_6")
			l_hash.put ([True, False,  False, key_strings.item (Key_7).twin.as_string_8], "shortcut_7")
			l_hash.put ([True, False,  False, key_strings.item (Key_8).twin.as_string_8], "shortcut_8")
			l_hash.put ([True, False,  False, key_strings.item (Key_9).twin.as_string_8], "shortcut_9")
			Result.extend ([l_hash, main_window_group])
		end

invariant
	preference_not_void: preferences /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
