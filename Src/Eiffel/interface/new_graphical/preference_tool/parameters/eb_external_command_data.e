indexing
	description: "Preferences for external commands."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNAL_COMMAND_DATA

inherit
	EB_SHORTCUTS_DATA

	EV_KEY_CONSTANTS
		export
			{NONE} all
		end

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

feature -- Access

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

feature {EB_SHARED_PREFERENCES} -- Access

	shortcuts: HASH_TABLE [SHORTCUT_PREFERENCE, STRING] is
			-- Shortcuts
		once
			create Result.make (default_shortcut_actions.count)
		end

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

feature {NONE} -- Preference Strings

	external_command_0_string: STRING is "general.external_commands.external_command_0"
	external_command_1_string: STRING is "general.external_commands.external_command_1"
	external_command_2_string: STRING is "general.external_commands.external_command_2"
	external_command_3_string: STRING is "general.external_commands.external_command_3"
	external_command_4_string: STRING is "general.external_commands.external_command_4"
	external_command_5_string: STRING is "general.external_commands.external_command_5"
	external_command_6_string: STRING is "general.external_commands.external_command_6"
	external_command_7_string: STRING is "general.external_commands.external_command_7"
	external_command_8_string: STRING is "general.external_commands.external_command_8"
	external_command_9_string: STRING is "general.external_commands.external_command_9"

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
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

			create l_manager.make (preferences, "shortcuts.external_commands")
			initialize_shortcuts_prefs (l_manager)
		end

	preferences: PREFERENCES
			-- Preferences

feature {NONE} -- Shortcuts

	default_shortcut_actions: ARRAYED_LIST [TUPLE [actions: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING_8], STRING_8]; group: MANAGED_SHORTCUT_GROUP]] is
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

end
