note
	description: "Make it easier to read shortcut preferences."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_SHORTCUTS_DATA

inherit
	EB_SHARED_SHORTCUT_MANAGER

feature {NONE} -- Implementation

	initialize_shortcuts_prefs (a_manager: EB_PREFERENCE_MANAGER)
			-- Initialize shortcuts.  Create with default values stored in `default_shortcut_actions'.
		require
			a_manager_not_void: a_manager /= Void
		local
			action_name: STRING
			default_value: TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING]
			l_name: STRING
			l_s_pref: SHORTCUT_PREFERENCE
			l_default_shortcut_actions: like default_shortcut_actions
			l_shortcuts: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING], STRING]
			l_group: MANAGED_SHORTCUT_GROUP
		do
			l_default_shortcut_actions := default_shortcut_actions
			from
				l_default_shortcut_actions.start
			until
				l_default_shortcut_actions.after
			loop
				l_shortcuts := l_default_shortcut_actions.item.actions
				l_group := l_default_shortcut_actions.item.group
				from
					l_shortcuts.start
				until
					l_shortcuts.after
				loop
					action_name := l_shortcuts.key_for_iteration
					default_value := l_shortcuts.item (action_name)
					l_name := a_manager.namespace + "." + action_name
					l_s_pref := a_manager.new_shortcut_preference_value (a_manager, l_name, default_value)
					l_s_pref.change_actions.extend (agent update)
					l_s_pref.set_group (l_group)
					shortcuts.put (l_s_pref, action_name)
					l_shortcuts.forth
				end
				l_default_shortcut_actions.forth
			end
		end

	shortcuts: STRING_TABLE [SHORTCUT_PREFERENCE]
			-- Shortcuts
		deferred
		ensure
			shortcuts_not_void: Result /= Void
		end

	default_shortcut_actions: ARRAYED_LIST [TUPLE [actions: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING], STRING]; group: MANAGED_SHORTCUT_GROUP]]
			-- Array of shortcut defaults (Alt/Ctrl/Shift/KeyString) & shortcut group
		deferred
		ensure
			default_shortcut_actions_not_void: Result /= Void
		end

	update
			-- Action called when updating preferences.
		do
			shortcut_manager.update_commands
		end

feature -- Shortcut group

	main_window_group: MANAGED_SHORTCUT_GROUP
		once
			create Result.make
		ensure
			Result_not_void: Result /= Void
		end

	completion_window_group: MANAGED_SHORTCUT_GROUP
		once
			create Result.make
		ensure
			Result_not_void: Result /= Void
		end

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
