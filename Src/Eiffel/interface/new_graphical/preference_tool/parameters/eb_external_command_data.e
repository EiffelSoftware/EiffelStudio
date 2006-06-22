indexing
	description: "Preferences for external commands."
	author: ""
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

			create l_manager.make (preferences, "general.external_commands")
			initialize_shortcuts_prefs (l_manager)
		end

	preferences: PREFERENCES
			-- Preferences

	update is
			-- Nothing to update
		do
		end

feature {NONE} -- Shortcuts

	default_shortcut_actions: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING], STRING] is
			-- Array of shortcut defaults (Alt/Ctrl/Shift/KeyString)
		once
			create Result.make (25)
			Result.put ([True, False,  False, key_strings.item (Key_0).twin.as_string_8], "shortcut_0")
			Result.put ([True, False,  False, key_strings.item (Key_1).twin.as_string_8], "shortcut_1")
			Result.put ([True, False,  False, key_strings.item (Key_2).twin.as_string_8], "shortcut_2")
			Result.put ([True, False,  False, key_strings.item (Key_3).twin.as_string_8], "shortcut_3")
			Result.put ([True, False,  False, key_strings.item (Key_4).twin.as_string_8], "shortcut_4")
			Result.put ([True, False,  False, key_strings.item (Key_5).twin.as_string_8], "shortcut_5")
			Result.put ([True, False,  False, key_strings.item (Key_6).twin.as_string_8], "shortcut_6")
			Result.put ([True, False,  False, key_strings.item (Key_7).twin.as_string_8], "shortcut_7")
			Result.put ([True, False,  False, key_strings.item (Key_8).twin.as_string_8], "shortcut_8")
			Result.put ([True, False,  False, key_strings.item (Key_9).twin.as_string_8], "shortcut_9")
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

end
