indexing
	description: "Make it easier to read shortcut preferences."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_SHORTCUTS_DATA

feature {NONE} -- Implementation

	initialize_shortcuts_prefs (a_manager: EB_PREFERENCE_MANAGER) is
			-- Initialize shortcuts.  Create with default values stored in `default_shortcut_actions'.
		require
			a_manager_not_void: a_manager /= Void
		local
			action_name: STRING
			default_value: TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING]
			l_name: STRING
			l_s_pref: SHORTCUT_PREFERENCE
			l_default_shortcut_actions: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING], STRING]
		do
			l_default_shortcut_actions := default_shortcut_actions
			from
				l_default_shortcut_actions.start
			until
				l_default_shortcut_actions.after
			loop
				action_name := default_shortcut_actions.key_for_iteration
				default_value := default_shortcut_actions.item (action_name)
				l_name := a_manager.namespace + "." + action_name
				l_s_pref := a_manager.new_shortcut_preference_value (a_manager, l_name, default_value)
				l_s_pref.change_actions.extend (agent update)
				shortcuts.put (l_s_pref, action_name)
				l_default_shortcut_actions.forth
			end
		end

	shortcuts: HASH_TABLE [SHORTCUT_PREFERENCE, STRING] is
			-- Shortcuts
		deferred
		ensure
			shortcuts_not_void: Result /= Void
		end

	default_shortcut_actions: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING], STRING] is
			-- Array of shortcut defaults (Alt/Ctrl/Shift/KeyString)
		deferred
		ensure
			default_shortcut_actions_not_void: Result /= Void
		end

	update is
			-- Action called when updating preferences.
		deferred
		end


end
