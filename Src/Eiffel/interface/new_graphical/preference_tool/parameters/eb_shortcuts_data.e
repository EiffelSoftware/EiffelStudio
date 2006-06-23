indexing
	description: "Make it easier to read shortcut preferences."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
